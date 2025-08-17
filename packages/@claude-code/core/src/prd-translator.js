#!/usr/bin/env node

/**
 * PRD Translator
 * Automatic Korean to English translation for Product Requirements Documents
 * Ensures all PRDs are maintained in English as the primary language
 */

const fs = require('fs').promises;
const path = require('path');

/**
 * Language detection patterns
 */
const KOREAN_PATTERN = /[\uAC00-\uD7AF\u1100-\u11FF\u3130-\u318F]/;
const KOREAN_THRESHOLD = 0.1; // 10% Korean characters indicates Korean document

/**
 * Detect the primary language of the content
 * @param {string} content - The text content to analyze
 * @returns {string} - 'ko' for Korean, 'en' for English
 */
function detectLanguage(content) {
  if (!content) return 'en';
  
  // Remove markdown formatting and code blocks for accurate detection
  const cleanContent = content
    .replace(/```[\s\S]*?```/g, '') // Remove code blocks
    .replace(/`[^`]*`/g, '')         // Remove inline code
    .replace(/^#+\s/gm, '')          // Remove headers
    .replace(/\[([^\]]*)\]\([^\)]*\)/g, '$1'); // Remove links
  
  // Count Korean characters
  const totalChars = cleanContent.replace(/\s/g, '').length;
  const koreanChars = (cleanContent.match(KOREAN_PATTERN) || []).length;
  
  const koreanRatio = totalChars > 0 ? koreanChars / totalChars : 0;
  
  return koreanRatio > KOREAN_THRESHOLD ? 'ko' : 'en';
}

/**
 * Translate Korean text to English
 * This is a placeholder for actual translation service integration
 * In production, this would use a service like Google Translate API or DeepL
 * 
 * @param {string} koreanText - Korean text to translate
 * @returns {Promise<string>} - Translated English text
 */
async function translateToEnglish(koreanText) {
  // Placeholder implementation
  // In production, replace with actual translation API call
  
  console.log('Translating Korean PRD to English...');
  
  // For demonstration, we'll do basic replacements of common PRD terms
  // This is NOT a real translation - just for testing
  const translations = {
    '요구사항': 'Requirements',
    '기능': 'Features',
    '사용자': 'User',
    '목표': 'Goals',
    '성공 지표': 'Success Metrics',
    '기술 사양': 'Technical Specification',
    '의존성': 'Dependencies',
    '위험': 'Risks',
    '일정': 'Timeline',
    '승인 기준': 'Acceptance Criteria',
    '문제 설명': 'Problem Statement',
    '개요': 'Overview',
    '배경': 'Background',
    '범위': 'Scope',
    '제약사항': 'Constraints',
    '가정': 'Assumptions',
    '이해관계자': 'Stakeholders',
    '우선순위': 'Priority',
    '테스트': 'Testing',
    '배포': 'Deployment',
    '모니터링': 'Monitoring',
    '롤백': 'Rollback',
    '성능': 'Performance',
    '보안': 'Security',
    '확장성': 'Scalability',
    '사용성': 'Usability',
    'API': 'API',
    '데이터베이스': 'Database',
    '인증': 'Authentication',
    '권한': 'Authorization',
    '로그인': 'Login',
    '로그아웃': 'Logout',
    '대시보드': 'Dashboard',
    '설정': 'Settings',
    '프로필': 'Profile',
    '알림': 'Notifications',
    '검색': 'Search',
    '필터': 'Filter',
    '정렬': 'Sort',
    '페이지네이션': 'Pagination',
    '검증': 'Validation',
    '에러 처리': 'Error Handling',
    '캐싱': 'Caching',
    '로깅': 'Logging',
    '백업': 'Backup',
    '복구': 'Recovery',
    '마이그레이션': 'Migration',
    '통합': 'Integration',
    '인터페이스': 'Interface',
    '응답 시간': 'Response Time',
    '처리량': 'Throughput',
    '가용성': 'Availability',
    '신뢰성': 'Reliability'
  };
  
  let translatedText = koreanText;
  
  // Replace known terms
  for (const [korean, english] of Object.entries(translations)) {
    const regex = new RegExp(korean, 'g');
    translatedText = translatedText.replace(regex, english);
  }
  
  // Add translation notice
  const notice = `<!-- 
NOTE: This document was automatically translated from Korean to English.
Original Korean version is preserved separately.
For production use, integrate with a professional translation service.
-->\n\n`;
  
  return notice + translatedText;
}

/**
 * Process PRD content with language detection and translation
 * @param {string} content - PRD content
 * @param {string} fileName - Original file name
 * @returns {Promise<Object>} - Processing result
 */
async function processPRD(content, fileName) {
  const language = detectLanguage(content);
  
  if (language === 'ko') {
    console.log(`Korean content detected in ${fileName}`);
    
    const translatedContent = await translateToEnglish(content);
    
    return {
      requiresTranslation: true,
      sourceLanguage: 'ko',
      targetLanguage: 'en',
      originalContent: content,
      translatedContent: translatedContent,
      originalFileName: fileName.replace('.md', '_original_ko.md'),
      translatedFileName: fileName
    };
  }
  
  return {
    requiresTranslation: false,
    sourceLanguage: 'en',
    targetLanguage: 'en',
    originalContent: content,
    translatedContent: content,
    originalFileName: fileName,
    translatedFileName: fileName
  };
}

/**
 * Save PRD files after translation
 * @param {Object} result - Processing result from processPRD
 * @param {string} outputDir - Directory to save files
 */
async function savePRDFiles(result, outputDir) {
  // Ensure output directory exists
  await fs.mkdir(outputDir, { recursive: true });
  
  if (result.requiresTranslation) {
    // Save original Korean version
    const originalPath = path.join(outputDir, result.originalFileName);
    await fs.writeFile(originalPath, result.originalContent, 'utf8');
    console.log(`Original Korean version saved: ${originalPath}`);
    
    // Save translated English version as primary
    const translatedPath = path.join(outputDir, result.translatedFileName);
    await fs.writeFile(translatedPath, result.translatedContent, 'utf8');
    console.log(`Translated English version saved: ${translatedPath}`);
    
    // Create metadata file
    const metadataPath = path.join(outputDir, result.translatedFileName.replace('.md', '_metadata.json'));
    const metadata = {
      translation: {
        required: true,
        sourceLanguage: result.sourceLanguage,
        targetLanguage: result.targetLanguage,
        translatedAt: new Date().toISOString(),
        originalFile: result.originalFileName,
        method: 'automatic'
      }
    };
    await fs.writeFile(metadataPath, JSON.stringify(metadata, null, 2), 'utf8');
    console.log(`Translation metadata saved: ${metadataPath}`);
  } else {
    // Save English version directly
    const filePath = path.join(outputDir, result.translatedFileName);
    await fs.writeFile(filePath, result.translatedContent, 'utf8');
    console.log(`PRD saved: ${filePath}`);
  }
}

/**
 * Validate translation quality
 * @param {string} original - Original text
 * @param {string} translated - Translated text
 * @returns {Object} - Validation result
 */
function validateTranslation(original, translated) {
  // Basic validation checks
  const checks = {
    notEmpty: translated.trim().length > 0,
    hasContent: translated.length > original.length * 0.5, // At least 50% of original length
    noKoreanInTranslation: !KOREAN_PATTERN.test(translated.replace(/<!--[\s\S]*?-->/g, '')), // Ignore comments
    preservesMarkdown: (original.match(/^#+\s/gm) || []).length === (translated.match(/^#+\s/gm) || []).length,
    preservesCodeBlocks: (original.match(/```/g) || []).length === (translated.match(/```/g) || []).length
  };
  
  const score = Object.values(checks).filter(Boolean).length / Object.keys(checks).length * 100;
  
  return {
    score,
    passed: score >= 80,
    checks,
    message: score >= 80 ? 'Translation validation passed' : 'Translation quality issues detected'
  };
}

/**
 * CLI interface for standalone usage
 */
async function cli() {
  const args = process.argv.slice(2);
  
  if (args.length < 1) {
    console.log('Usage: prd-translator.js <input-file> [output-dir]');
    console.log('Example: prd-translator.js my-prd.md docs/prd/draft/');
    process.exit(1);
  }
  
  const inputFile = args[0];
  const outputDir = args[1] || path.dirname(inputFile);
  const fileName = path.basename(inputFile);
  
  try {
    // Read input file
    const content = await fs.readFile(inputFile, 'utf8');
    
    // Process PRD
    const result = await processPRD(content, fileName);
    
    // Validate if translation occurred
    if (result.requiresTranslation) {
      const validation = validateTranslation(result.originalContent, result.translatedContent);
      console.log(`Translation validation: ${validation.message} (Score: ${validation.score}%)`);
      
      if (!validation.passed) {
        console.warn('Warning: Translation quality may need manual review');
        console.log('Failed checks:', Object.entries(validation.checks)
          .filter(([, passed]) => !passed)
          .map(([check]) => check)
          .join(', '));
      }
    }
    
    // Save files
    await savePRDFiles(result, outputDir);
    
    console.log('PRD processing completed successfully');
  } catch (error) {
    console.error('Error processing PRD:', error.message);
    process.exit(1);
  }
}

// Export functions for use as module
module.exports = {
  detectLanguage,
  translateToEnglish,
  processPRD,
  savePRDFiles,
  validateTranslation
};

// Run CLI if called directly
if (require.main === module) {
  cli();
}