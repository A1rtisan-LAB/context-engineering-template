#!/usr/bin/env python3
"""
GPT-based PR Code Review Script
Uses OpenAI's GPT-4o-mini for cost-effective code reviews
"""

import os
import sys
import json
import re
from typing import List, Dict, Any
from github import Github
import openai
from openai import OpenAI

# Configuration
MAX_FILES_PER_REVIEW = 10
MAX_LINES_PER_FILE = 500
MAX_TOKENS_PER_REVIEW = 4000
MODEL = "gpt-4o-mini"  # Most cost-effective model

# File extensions to review
REVIEW_EXTENSIONS = {
    '.py', '.js', '.ts', '.jsx', '.tsx', '.java', '.cpp', '.c', '.h',
    '.go', '.rs', '.rb', '.php', '.swift', '.kt', '.scala', '.sh',
    '.yml', '.yaml', '.json', '.md'
}

class GPTReviewer:
    def __init__(self):
        self.client = OpenAI(api_key=os.environ['OPENAI_API_KEY'])
        self.github = Github(os.environ['GITHUB_TOKEN'])
        self.repo = self.github.get_repo(os.environ['GITHUB_REPOSITORY'])
        self.pr_number = int(os.environ['PR_NUMBER'])
        self.pr = self.repo.get_pull(self.pr_number)
        self.total_tokens = 0
        self.total_cost = 0.0
        
    def should_review_file(self, filename: str) -> bool:
        """Check if file should be reviewed based on extension"""
        return any(filename.endswith(ext) for ext in REVIEW_EXTENSIONS)
    
    def get_pr_files(self) -> List[Dict[str, Any]]:
        """Get changed files in PR"""
        files = []
        for file in self.pr.get_files():
            if self.should_review_file(file.filename):
                if file.additions + file.deletions <= MAX_LINES_PER_FILE:
                    files.append({
                        'filename': file.filename,
                        'patch': file.patch if file.patch else '',
                        'status': file.status,
                        'additions': file.additions,
                        'deletions': file.deletions
                    })
        return files[:MAX_FILES_PER_REVIEW]
    
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
    
    def format_review_comment(self, review: str) -> str:
        """Format the review as a GitHub comment"""
        comment = "## 🤖 AI Code Review by GPT-4o-mini\n\n"
        
        # Add summary stats
        files = self.get_pr_files()
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
        comment += "*This is an automated review by GPT. Please verify suggestions before implementing.*\n"
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
        """Main review process"""
        print(f"Starting GPT review for PR #{self.pr_number}")
        
        # Get files to review
        files = self.get_pr_files()
        if not files:
            print("No reviewable files found")
            self.pr.create_issue_comment(
                "ℹ️ **No files to review**\n\n"
                "No supported file types were changed in this PR, or all changes exceed the size limit."
            )
            return
        
        print(f"Reviewing {len(files)} files...")
        
        # Create prompt and get review
        prompt = self.create_review_prompt(files)
        review = self.review_with_gpt(prompt)
        
        # Format and post review
        comment = self.format_review_comment(review)
        self.post_review(comment)
        
        print(f"Review completed. Tokens: {self.total_tokens}, Cost: ${self.total_cost:.4f}")

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