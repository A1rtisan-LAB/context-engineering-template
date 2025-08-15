## FEATURE:
Implement asynchronous email notification system
- Email sending using Gmail API
- Recipient information search using Brave Search API
- Data validation using Pydantic
- Include retry logic and error handling
- Provide CLI interface

## EXAMPLES:
Files in examples/ folder:
- `examples/api/client.py` - Reference API client implementation pattern
- `examples/architecture/agent/` - Reference agent architecture pattern
- `examples/tests/` - Reference test writing pattern
- `examples/_patterns/error-handling.md` - Reference error handling pattern

Use these examples as inspiration for best practices, don't copy them directly.

## DOCUMENTATION:
- Gmail API: https://developers.google.com/gmail/api
- Brave Search API: https://brave.com/search/api/
- Pydantic documentation: https://docs.pydantic.dev/
- Python asyncio: https://docs.python.org/3/library/asyncio.html

## OTHER CONSIDERATIONS:
- Include .env.example file
- Write README including setup instructions
- Include project structure in README
- Use python-dotenv for environment variables
- Use asyncio for asynchronous processing
- Never hardcode API keys
- Consider rate limits (Gmail API allows 250 requests per minute)