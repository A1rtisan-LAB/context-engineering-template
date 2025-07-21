# 입력 검증 패턴

## 검증 원칙
1. 경계에서 검증 (API 입구, 사용자 입력)
2. 타입 안전성 보장
3. 명확한 에러 메시지
4. 재사용 가능한 검증 로직

## Python (Pydantic) 예시
```python
from pydantic import BaseModel, EmailStr, validator
from typing import Optional
from datetime import datetime

class UserCreateRequest(BaseModel):
    email: EmailStr
    name: str
    age: Optional[int] = None
    
    @validator('name')
    def name_must_not_be_empty(cls, v):
        if not v.strip():
            raise ValueError('Name cannot be empty')
        return v
    
    @validator('age')
    def age_must_be_positive(cls, v):
        if v is not None and v <= 0:
            raise ValueError('Age must be positive')
        return v

# 사용 예시
def create_user(data: dict):
    validated_data = UserCreateRequest(**data)  # 자동 검증
    return save_user(validated_data.dict())
```

## TypeScript (Zod) 예시
```typescript
import { z } from 'zod';

const UserCreateSchema = z.object({
  email: z.string().email(),
  name: z.string().min(1, 'Name cannot be empty'),
  age: z.number().positive().optional(),
});

type UserCreateRequest = z.infer<typeof UserCreateSchema>;

// 사용 예시
export const createUser = async (data: unknown) => {
  const validatedData = UserCreateSchema.parse(data); // 자동 검증
  return await saveUser(validatedData);
};

// Express 미들웨어
export const validateBody = (schema: z.ZodSchema) => {
  return (req: Request, res: Response, next: NextFunction) => {
    try {
      req.body = schema.parse(req.body);
      next();
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({
          error: 'Validation failed',
          details: error.errors
        });
      }
      next(error);
    }
  };
};
```