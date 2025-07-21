# 에러 처리 패턴

## 기본 원칙
1. 예상 가능한 에러는 명시적으로 처리
2. 사용자 친화적인 에러 메시지
3. 로깅과 모니터링
4. 복구 가능한 에러는 재시도

## Python 예시
```python
class AppError(Exception):
    """애플리케이션 기본 에러"""
    def __init__(self, message: str, code: str = None):
        self.message = message
        self.code = code
        super().__init__(self.message)

class ValidationError(AppError):
    """검증 에러"""
    pass

def handle_errors(func):
    """에러 처리 데코레이터"""
    async def wrapper(*args, **kwargs):
        try:
            return await func(*args, **kwargs)
        except ValidationError as e:
            logger.warning(f"Validation error: {e.message}")
            return {"error": e.message, "code": e.code}
        except Exception as e:
            logger.error(f"Unexpected error: {str(e)}")
            return {"error": "Internal server error", "code": "INTERNAL_ERROR"}
    return wrapper
```

## TypeScript 예시
```typescript
export class AppError extends Error {
  constructor(
    public message: string,
    public code?: string,
    public statusCode?: number
  ) {
    super(message);
    this.name = this.constructor.name;
  }
}

export const errorHandler = (
  err: Error,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  if (err instanceof AppError) {
    return res.status(err.statusCode || 400).json({
      error: err.message,
      code: err.code
    });
  }
  
  console.error(err);
  return res.status(500).json({
    error: 'Internal server error',
    code: 'INTERNAL_ERROR'
  });
};
```