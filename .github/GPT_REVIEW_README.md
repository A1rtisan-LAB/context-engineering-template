# 🤖 GPT AI Code Review System

Automated PR code review using OpenAI's GPT-4o-mini for cost-effective, intelligent feedback.

## ✨ Features

- **Automatic PR Reviews**: Triggered on PR creation and updates
- **Manual Trigger**: Comment `/review` on any PR
- **Cost Optimization**: Uses GPT-4o-mini (ultra low cost)
- **Smart Limits**: Daily review limits and size restrictions
- **Usage Tracking**: Monitor token usage and costs
- **Multi-language Support**: Python, JavaScript, TypeScript, Java, Go, and more

## 💰 Costs

Using GPT-4o-mini (most cost-effective):
- **Per Review**: ~$0.001-0.005 (약 1-7원)
- **Monthly (100 PRs)**: ~$0.50 (약 650원)
- **Free Credits**: OpenAI provides $5-18 free credits for new accounts

## 🚀 Setup

### 1. Get OpenAI API Key
1. Sign up at [OpenAI Platform](https://platform.openai.com)
2. Create an API key
3. You'll get $5-18 free credits

### 2. Add GitHub Secret
1. Go to your repository Settings → Secrets and variables → Actions
2. Add new secret: `OPENAI_API_KEY`
3. Paste your OpenAI API key

### 3. Enable Workflow
The workflow is automatically enabled when merged to main branch.

## 📖 Usage

### Automatic Review
PRs are automatically reviewed when:
- PR is opened (not draft, not WIP)
- PR is updated with new commits
- Less than 1000 lines changed
- Daily limit not exceeded (10 reviews/day)

### Manual Commands
Comment on any PR:
- `/review` - Trigger a manual review
- `/usage` - Check daily usage stats

### Skip Conditions
Reviews are skipped for:
- Draft PRs
- PRs with "WIP" in title
- PRs over 1000 lines
- After 10 reviews per day

## ⚙️ Configuration

Edit `.github/gpt-review.config.json` to customize:
- Model selection
- File size limits
- Review limits
- File extensions to review
- Cost limits

## 📊 Cost Monitoring

The system tracks:
- Tokens used per review
- Estimated cost per review
- Daily usage counter
- Shows cost in each review comment

## 🛡️ Security

- API key stored in GitHub Secrets
- No code sent to external services except OpenAI
- Review comments are public on PR

## 🔧 Troubleshooting

### No Review Posted
- Check if `OPENAI_API_KEY` is set in GitHub Secrets
- Verify PR isn't draft or WIP
- Check daily limit with `/usage` command

### API Errors
- Verify API key is valid
- Check OpenAI account has credits
- Ensure API key has proper permissions

## 📈 Example Review

```markdown
## 🤖 AI Code Review by GPT-4o-mini

### 📊 Summary
- Files reviewed: 3
- Total changes: +150 -45
- Model: gpt-4o-mini

### 🔍 Review Details

**security.py:45** 🔴 Critical
- SQL injection vulnerability detected
- Use parameterized queries instead of string concatenation

**utils.js:102** 🟡 Warning  
- Unused variable 'tempData'
- Consider removing or implementing planned functionality

### 💰 Usage
- Tokens used: 1,234
- Estimated cost: $0.0018
```

## 🤝 Contributing

Feel free to submit issues or PRs to improve the review system!

## 📝 License

Part of the Context Engineering Template project (MIT License)