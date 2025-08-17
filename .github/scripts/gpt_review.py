#!/usr/bin/env python3
"""
GPT-based PR Code Review Script with Intelligent Chunking Support

This script provides automated code review for GitHub Pull Requests using OpenAI's GPT-4o-mini model.
It supports large PRs through intelligent file chunking to handle up to 20,000 lines of code changes.

Main Features:
- Automatic PR diff analysis and file filtering
- Intelligent chunking for large PRs (>2,000 lines)
- Cost-effective GPT-4o-mini model usage
- Structured review feedback with severity levels
- GitHub comment integration with update support

Environment Variables Required:
- GITHUB_TOKEN: GitHub API token for PR access
- OPENAI_API_KEY: OpenAI API key for GPT access
- PR_NUMBER: Pull request number to review
- USE_CHUNKS: Enable chunking for large PRs (optional)
- DEBUG_MODE: Enable debug output (optional)

Usage:
    python gpt_review.py

Author: Claude Code Context Engineering Template
Version: 2.0.0
"""

import os
import sys
import json
import re
import time
from typing import List, Dict, Any, Tuple, Optional
from github import Github
import openai
from openai import OpenAI

# Configuration
MAX_FILES_PER_REVIEW = 10
MAX_LINES_PER_FILE = 500
MAX_LINES_PER_CHUNK = 2000  # Optimal chunk size for GPT-4o-mini
MAX_TOKENS_PER_REVIEW = 4000
MODEL = "gpt-4o-mini"  # Most cost-effective model
ENABLE_CHUNKING = True  # Enable chunking for large PRs

# File extensions to review with priority
REVIEW_EXTENSIONS = {
    '.py', '.js', '.ts', '.jsx', '.tsx', '.java', '.cpp', '.c', '.h',
    '.go', '.rs', '.rb', '.php', '.swift', '.kt', '.scala', '.sh',
    '.yml', '.yaml', '.json', '.md'
}

# Priority for file types (higher = more important)
FILE_PRIORITY = {
    '.py': 10, '.js': 10, '.ts': 10, '.jsx': 9, '.tsx': 9,
    '.java': 10, '.go': 10, '.rs': 10, '.cpp': 9, '.c': 9,
    '.rb': 8, '.php': 8, '.swift': 8, '.kt': 8,
    '.yml': 5, '.yaml': 5, '.json': 5, '.sh': 6,
    '.md': 2  # Lower priority for documentation
}

class ChunkManager:
    """Manages intelligent chunking of PR files for review.
    
    This class handles the splitting of large PRs into manageable chunks
    for GPT review. It prioritizes files by type and ensures logical
    boundaries are preserved when splitting.
    
    Attributes:
        max_lines (int): Maximum lines per chunk (default: 2000)
        chunks (List[List[Dict]]): List of file chunks for review
    
    Example:
        >>> manager = ChunkManager(max_lines_per_chunk=2000)
        >>> files = [{'filename': 'main.py', 'additions': 100, 'deletions': 50, ...}]
        >>> chunks = manager.create_chunks(files)
        >>> print(f"Created {len(chunks)} chunks")
    """
    
    def __init__(self, max_lines_per_chunk=MAX_LINES_PER_CHUNK):
        self.max_lines = max_lines_per_chunk
        self.chunks = []
    
    def create_chunks(self, files: List[Dict[str, Any]]) -> List[List[Dict[str, Any]]]:
        """Create optimized chunks from PR files.
        
        Args:
            files: List of file dictionaries containing filename, additions,
                  deletions, status, and patch information
        
        Returns:
            List of file chunks, where each chunk contains files that total
            less than max_lines changes
        
        Note:
            Files are sorted by priority (code files first, docs last) and
            large files are automatically split at logical boundaries.
        """
        # Input validation
        if not files:
            return []
        
        if not isinstance(files, list):
            raise TypeError(f"Expected list of files, got {type(files)}")
        
        # Sort files by priority
        sorted_files = sorted(files, 
                             key=lambda f: FILE_PRIORITY.get(
                                 self._get_extension(f.get('filename', '')), 0), 
                             reverse=True)
        
        current_chunk = []
        current_lines = 0
        
        for file in sorted_files:
            file_lines = file['additions'] + file['deletions']
            
            # If single file exceeds chunk size, split it
            if file_lines > self.max_lines:
                # Save current chunk if not empty
                if current_chunk:
                    self.chunks.append(current_chunk)
                    current_chunk = []
                    current_lines = 0
                
                # Split large file
                split_files = self._split_large_file(file)
                for split_file in split_files:
                    self.chunks.append([split_file])
            
            # If adding file exceeds chunk size, start new chunk
            elif current_lines + file_lines > self.max_lines:
                if current_chunk:
                    self.chunks.append(current_chunk)
                current_chunk = [file]
                current_lines = file_lines
            
            # Add file to current chunk
            else:
                current_chunk.append(file)
                current_lines += file_lines
        
        # Add remaining files
        if current_chunk:
            self.chunks.append(current_chunk)
        
        return self.chunks
    
    def _split_large_file(self, file: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Split a large file into smaller chunks at logical boundaries.
        
        Args:
            file: File dictionary with patch content exceeding max_lines
        
        Returns:
            List of file chunks with preserved logical boundaries
            (e.g., function/class definitions)
        
        Note:
            Attempts to split at function/class boundaries for code files,
            falls back to line-based splitting if necessary.
        """
        # Input validation
        if not file or 'patch' not in file:
            return [file] if file else []
        
        patches = file.get('patch', '').split('\n')
        chunks = []
        current_patch = []
        current_lines = 0
        
        for line in patches:
            # Try to split at function/class boundaries for code files
            if self._is_logical_boundary(line, file['filename']):
                if current_lines > self.max_lines * 0.7:  # 70% threshold
                    # Create chunk
                    chunk = file.copy()
                    chunk['patch'] = '\n'.join(current_patch)
                    chunk['additions'] = sum(1 for l in current_patch if l.startswith('+'))
                    chunk['deletions'] = sum(1 for l in current_patch if l.startswith('-'))
                    chunk['chunk_info'] = f"Part {len(chunks) + 1}"
                    chunks.append(chunk)
                    
                    current_patch = [line]
                    current_lines = 1
                    continue
            
            current_patch.append(line)
            current_lines += 1
            
            # Force split if reaching max lines
            if current_lines >= self.max_lines:
                chunk = file.copy()
                chunk['patch'] = '\n'.join(current_patch)
                chunk['additions'] = sum(1 for l in current_patch if l.startswith('+'))
                chunk['deletions'] = sum(1 for l in current_patch if l.startswith('-'))
                chunk['chunk_info'] = f"Part {len(chunks) + 1}"
                chunks.append(chunk)
                
                current_patch = []
                current_lines = 0
        
        # Add remaining lines
        if current_patch:
            chunk = file.copy()
            chunk['patch'] = '\n'.join(current_patch)
            chunk['additions'] = sum(1 for l in current_patch if l.startswith('+'))
            chunk['deletions'] = sum(1 for l in current_patch if l.startswith('-'))
            chunk['chunk_info'] = f"Part {len(chunks) + 1}"
            chunks.append(chunk)
        
        return chunks if chunks else [file]
    
    def _is_logical_boundary(self, line: str, filename: str) -> bool:
        """Detect logical boundaries in code (function/class definitions)"""
        ext = self._get_extension(filename)
        
        # Python
        if ext == '.py' and (line.startswith('+def ') or line.startswith('+class ')):
            return True
        
        # JavaScript/TypeScript
        if ext in ['.js', '.ts', '.jsx', '.tsx']:
            if 'function ' in line or 'class ' in line or 'const ' in line:
                return True
        
        # Java/C++/C
        if ext in ['.java', '.cpp', '.c', '.h']:
            if re.match(r'^[+]\s*(public|private|protected|static)\s+', line):
                return True
        
        return False
    
    def _get_extension(self, filename: str) -> str:
        """Get file extension from filename.
        
        Args:
            filename: Path to file or filename
        
        Returns:
            File extension including dot (e.g., '.py', '.js')
        """
        if not filename:
            return ''
        for ext in FILE_PRIORITY.keys():
            if filename.endswith(ext):
                return ext
        return ''


class GPTReviewer:
    """Main class for GPT-based PR code review.
    
    Handles GitHub PR interaction, GPT API calls, and review posting.
    Supports both standard and chunked review modes for large PRs.
    
    Attributes:
        client: OpenAI client instance
        github: GitHub API client
        repo: GitHub repository object
        pr_number: Pull request number to review
        pr: Pull request object
        enable_chunking: Whether to enable chunking for large PRs
        chunk_manager: ChunkManager instance for handling large PRs
    """
    
    def __init__(self, enable_chunking: bool = ENABLE_CHUNKING):
        self.client = OpenAI(api_key=os.environ['OPENAI_API_KEY'])
        self.github = Github(os.environ['GITHUB_TOKEN'])
        self.repo = self.github.get_repo(os.environ['GITHUB_REPOSITORY'])
        self.pr_number = int(os.environ['PR_NUMBER'])
        self.pr = self.repo.get_pull(self.pr_number)
        self.total_tokens = 0
        self.total_cost = 0.0
        self.enable_chunking = enable_chunking
        self.chunk_manager = ChunkManager() if enable_chunking else None
        self.debug_mode = os.environ.get('DEBUG_MODE', 'false').lower() == 'true'
        self.all_reviews = []  # Store all chunk reviews
        
    def should_review_file(self, filename: str) -> bool:
        """Check if file should be reviewed based on extension"""
        return any(filename.endswith(ext) for ext in REVIEW_EXTENSIONS)
    
    def get_pr_files(self) -> List[Dict[str, Any]]:
        """Get changed files in PR"""
        files = []
        total_lines = 0
        
        for file in self.pr.get_files():
            if self.should_review_file(file.filename):
                # In chunking mode, get all files regardless of size
                if self.enable_chunking or (file.additions + file.deletions <= MAX_LINES_PER_FILE):
                    files.append({
                        'filename': file.filename,
                        'patch': file.patch if file.patch else '',
                        'status': file.status,
                        'additions': file.additions,
                        'deletions': file.deletions
                    })
                    total_lines += file.additions + file.deletions
        
        print(f"Total PR size: {total_lines} lines across {len(files)} files")
        
        # If not chunking, limit files
        if not self.enable_chunking:
            return files[:MAX_FILES_PER_REVIEW]
        
        return files
    
    def create_review_prompt(self, files: List[Dict[str, Any]]) -> str:
        """Create prompt for GPT review"""
        prompt = """You are an expert code reviewer. Review the following PR changes and provide constructive feedback.
Focus on:
1. Code quality and best practices
2. Potential bugs or issues
3. Security vulnerabilities
4. Performance concerns
5. Code readability and maintainability

For each issue found, specify:
- File and line number
- Severity (🔴 Critical, 🟡 Warning, 🟢 Suggestion)
- Clear explanation
- Suggested fix if applicable

PR Title: {title}
PR Description: {description}

Changed Files:
""".format(
            title=self.pr.title,
            description=self.pr.body[:500] if self.pr.body else "No description"
        )
        
        for file in files:
            prompt += f"\n\n### File: {file['filename']} ({file['status']})\n"
            prompt += f"Changes: +{file['additions']} -{file['deletions']}\n"
            prompt += "```diff\n"
            prompt += file['patch'][:2000]  # Limit patch size
            prompt += "\n```"
        
        prompt += "\n\nProvide a structured review with actionable feedback."
        return prompt
    
    def review_with_gpt(self, prompt: str) -> str:
        """Send prompt to GPT and get review"""
        try:
            response = self.client.chat.completions.create(
                model=MODEL,
                messages=[
                    {"role": "system", "content": "You are a helpful code reviewer focused on improving code quality."},
                    {"role": "user", "content": prompt}
                ],
                max_tokens=MAX_TOKENS_PER_REVIEW,
                temperature=0.3
            )
            
            # Calculate tokens and cost
            self.total_tokens = response.usage.total_tokens
            # GPT-4o-mini pricing: $0.00015 per 1K input tokens, $0.0006 per 1K output tokens
            input_cost = (response.usage.prompt_tokens / 1000) * 0.00015
            output_cost = (response.usage.completion_tokens / 1000) * 0.0006
            self.total_cost = input_cost + output_cost
            
            return response.choices[0].message.content
        except Exception as e:
            return f"Error calling GPT API: {str(e)}"
    
    def format_review_comment(self, review: str, chunk_info: Dict[str, Any] = None) -> str:
        """Format the review as a GitHub comment"""
        comment = "## 🤖 AI Code Review by GPT-4o-mini\n\n"
        
        # Add chunk info if using chunking
        if chunk_info:
            comment += "### 📦 Chunked Review\n"
            comment += f"- Total chunks processed: {chunk_info['total_chunks']}\n"
            comment += f"- Files reviewed: {chunk_info['files_reviewed']}\n"
            comment += f"- Total lines: {chunk_info['total_lines']}\n\n"
        
        # Add summary stats
        files = self.get_pr_files() if not chunk_info else []
        if files and not chunk_info:
            comment += "### 📊 Summary\n"
            comment += f"- Files reviewed: {len(files)}\n"
            comment += f"- Total changes: +{sum(f['additions'] for f in files)} -{sum(f['deletions'] for f in files)}\n"
        
        comment += f"- Model: {MODEL}\n\n"
        
        # Add review content
        comment += "### 🔍 Review Details\n\n"
        comment += review
        
        # Add token usage
        comment += f"\n\n### 💰 Usage\n"
        comment += f"- Tokens used: {self.total_tokens:,}\n"
        comment += f"- Estimated cost: ${self.total_cost:.4f}\n"
        
        # Add footer
        comment += "\n---\n"
        comment += "*This is an automated review by GPT. "
        if chunk_info:
            comment += "Large PR was processed in chunks. "
        comment += "Please verify suggestions before implementing.*\n"
        comment += "*Reply with `/review` to trigger a new review, or `/usage` to check daily usage.*"
        
        return comment
    
    def post_review(self, review_text: str):
        """Post review as PR comment"""
        try:
            # Check if we already posted a review
            existing_comments = list(self.pr.get_issue_comments())
            ai_comments = [c for c in existing_comments if '🤖 AI Code Review' in c.body]
            
            if ai_comments:
                # Update existing comment
                ai_comments[-1].edit(review_text)
                print(f"Updated existing review comment")
            else:
                # Create new comment
                self.pr.create_issue_comment(review_text)
                print(f"Posted new review comment")
                
        except Exception as e:
            print(f"Error posting review: {str(e)}")
            sys.exit(1)
    
    def run(self):
        """Main review process with optional chunking"""
        print(f"Starting GPT review for PR #{self.pr_number}")
        
        if self.debug_mode:
            print(f"[DEBUG] Chunking enabled: {self.enable_chunking}")
            print(f"[DEBUG] Max lines per chunk: {MAX_LINES_PER_CHUNK}")
            print(f"[DEBUG] Max files per review: {MAX_FILES_PER_REVIEW}")
        
        # Get files to review
        files = self.get_pr_files()
        if not files:
            print("No reviewable files found")
            self.pr.create_issue_comment(
                "ℹ️ **No files to review**\n\n"
                "No supported file types were changed in this PR, or all changes exceed the size limit."
            )
            return
        
        # Check if chunking is needed
        total_lines = sum(f['additions'] + f['deletions'] for f in files)
        
        if self.debug_mode:
            print(f"[DEBUG] Total files: {len(files)}")
            print(f"[DEBUG] Total lines: {total_lines}")
        
        if self.enable_chunking and total_lines > MAX_LINES_PER_CHUNK:
            print(f"Large PR detected ({total_lines} lines). Using chunked review...")
            self.run_chunked_review(files)
        else:
            print(f"Reviewing {len(files)} files...")
            
            # Limit files for non-chunked review
            review_files = files[:MAX_FILES_PER_REVIEW]
            
            # Create prompt and get review
            prompt = self.create_review_prompt(review_files)
            review = self.review_with_gpt(prompt)
            
            # Format and post review
            comment = self.format_review_comment(review)
            self.post_review(comment)
        
        print(f"Review completed. Total tokens: {self.total_tokens:,}, Total cost: ${self.total_cost:.4f}")
    
    def run_chunked_review(self, files: List[Dict[str, Any]]):
        """Run review in chunks for large PRs and post each chunk separately"""
        # Create chunks
        chunks = self.chunk_manager.create_chunks(files)
        print(f"Created {len(chunks)} chunks for review")
        
        if self.debug_mode:
            for i, chunk in enumerate(chunks):
                chunk_lines = sum(f['additions'] + f['deletions'] for f in chunk)
                print(f"[DEBUG] Chunk {i+1}: {len(chunk)} files, {chunk_lines} lines")
        
        chunk_reviews = []
        files_reviewed = set()
        total_lines = 0
        critical_count = 0
        warning_count = 0
        suggestion_count = 0
        
        # First, post a summary comment
        summary_comment = self._create_summary_header(len(chunks), len(files))
        self.pr.create_issue_comment(summary_comment)
        print("Posted summary comment")
        
        for i, chunk in enumerate(chunks):
            print(f"Processing chunk {i+1}/{len(chunks)}...")
            
            # Track files
            chunk_files = []
            for file in chunk:
                files_reviewed.add(file['filename'])
                chunk_files.append(file['filename'])
                total_lines += file['additions'] + file['deletions']
            
            # Create prompt for chunk
            prompt = self.create_review_prompt(chunk)
            prompt += f"\n\nNote: This is chunk {i+1} of {len(chunks)} in a large PR review."
            
            # Get review for chunk
            review = self.review_with_gpt(prompt)
            chunk_reviews.append(review)
            
            # Count issues in this chunk
            critical_count += review.count('🔴 Critical')
            warning_count += review.count('🟡 Warning')
            suggestion_count += review.count('🟢 Suggestion')
            
            # Post this chunk's review as a separate comment
            chunk_comment = self._format_chunk_comment(i+1, len(chunks), chunk_files, review)
            self.pr.create_issue_comment(chunk_comment)
            print(f"Posted review for chunk {i+1}/{len(chunks)}")
            
            # Rate limit handling
            if i < len(chunks) - 1:
                time.sleep(2)  # 2 second delay between chunks to avoid rate limits
        
        # Post final summary with statistics
        final_summary = self._create_final_summary(
            len(chunks), len(files_reviewed), total_lines,
            critical_count, warning_count, suggestion_count
        )
        self.pr.create_issue_comment(final_summary)
        print("Posted final summary")
    
    def merge_chunk_reviews(self, reviews: List[str]) -> str:
        """Merge multiple chunk reviews into one coherent review"""
        if len(reviews) == 1:
            return reviews[0]
        
        all_issues = []
        
        # Simply combine all reviews with chunk markers
        for i, review in enumerate(reviews):
            if review.strip():
                chunk_header = f"\n## 📦 Chunk {i+1} of {len(reviews)}\n"
                all_issues.append(chunk_header)
                all_issues.append(review)
        
        # Join all reviews
        merged_content = '\n'.join(all_issues)
        
        # Return a summarized version if too long
        if len(merged_content) > 20000:  # GitHub comment limit
            return self._summarize_reviews(reviews)
        
        return merged_content
    
    def _summarize_reviews(self, reviews: List[str]) -> str:
        """Create a summary when full review is too long"""
        summary = []
        summary.append("## 📊 Review Summary (Content truncated due to size)")
        summary.append("")
        
        critical_count = 0
        warning_count = 0
        suggestion_count = 0
        
        for review in reviews:
            critical_count += review.count('🔴 Critical')
            warning_count += review.count('🟡 Warning')
            suggestion_count += review.count('🟢 Suggestion')
        
        summary.append(f"- **Critical Issues**: {critical_count}")
        summary.append(f"- **Warnings**: {warning_count}")
        summary.append(f"- **Suggestions**: {suggestion_count}")
        summary.append("")
        summary.append("### Key Findings (First 3 chunks)")
        summary.append("")
        
        # Include first 3 chunks partially
        for i, review in enumerate(reviews[:3]):
            lines = review.split('\n')[:20]  # First 20 lines of each chunk
            summary.append(f"#### Chunk {i+1}")
            summary.extend(lines)
            summary.append("")
        
        summary.append("*Full review was too large for a single comment. Consider reviewing smaller PRs for detailed feedback.*")
        
        return '\n'.join(summary)
    
    def _create_summary_header(self, total_chunks: int, total_files: int) -> str:
        """Create initial summary header for chunked review"""
        header = []
        header.append("## 🤖 AI Code Review by GPT-4o-mini (Large PR)")
        header.append("")
        header.append(f"### 📦 Chunked Review Starting")
        header.append(f"- Total chunks to process: {total_chunks}")
        header.append(f"- Total files to review: {total_files}")
        header.append(f"- Model: {MODEL}")
        header.append("")
        header.append("📝 **Note**: This large PR will be reviewed in multiple parts.")
        header.append("Each chunk will be posted as a separate comment for better readability.")
        header.append("")
        header.append("⏳ Processing chunks...")
        return '\n'.join(header)
    
    def _format_chunk_comment(self, chunk_num: int, total_chunks: int, 
                             files: List[str], review: str) -> str:
        """Format individual chunk review comment"""
        comment = []
        comment.append(f"## 📦 AI Review - Part {chunk_num}/{total_chunks}")
        comment.append("")
        comment.append(f"### Files in this chunk ({len(files)} files):")
        for file in files[:10]:  # Show first 10 files
            comment.append(f"- `{file}`")
        if len(files) > 10:
            comment.append(f"- ... and {len(files) - 10} more files")
        comment.append("")
        comment.append("### 🔍 Review Details")
        comment.append("")
        comment.append(review)
        comment.append("")
        comment.append("---")
        comment.append(f"*Part {chunk_num} of {total_chunks} - Review continues in next comment*")
        return '\n'.join(comment)
    
    def _create_final_summary(self, chunks: int, files: int, lines: int,
                            critical: int, warnings: int, suggestions: int) -> str:
        """Create final summary comment after all chunks"""
        summary = []
        summary.append("## ✅ AI Code Review Complete")
        summary.append("")
        summary.append("### 📊 Final Statistics")
        summary.append(f"- **Total chunks processed**: {chunks}")
        summary.append(f"- **Files reviewed**: {files}")
        summary.append(f"- **Lines analyzed**: {lines:,}")
        summary.append("")
        summary.append("### 🎯 Issue Summary")
        summary.append(f"- 🔴 **Critical Issues**: {critical}")
        summary.append(f"- 🟡 **Warnings**: {warnings}")
        summary.append(f"- 🟢 **Suggestions**: {suggestions}")
        summary.append(f"- **Total Issues**: {critical + warnings + suggestions}")
        summary.append("")
        summary.append("### 💰 Usage")
        summary.append(f"- Tokens used: {self.total_tokens:,}")
        summary.append(f"- Estimated cost: ${self.total_cost:.4f}")
        summary.append("")
        summary.append("---")
        summary.append("*This review was split into multiple comments due to size.*")
        summary.append("*Please review all parts above for complete feedback.*")
        summary.append("*Reply with `/review` to trigger a new review.*")
        return '\n'.join(summary)

if __name__ == "__main__":
    # Check for required environment variables
    required_vars = ['OPENAI_API_KEY', 'GITHUB_TOKEN', 'GITHUB_REPOSITORY', 'PR_NUMBER']
    missing_vars = [var for var in required_vars if not os.environ.get(var)]
    
    if missing_vars:
        print(f"Error: Missing environment variables: {', '.join(missing_vars)}")
        sys.exit(1)
    
    # Run reviewer
    reviewer = GPTReviewer()
    reviewer.run()