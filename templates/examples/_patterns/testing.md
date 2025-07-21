# 테스트 작성 패턴

## 테스트 구조 (AAA 패턴)
1. **Arrange**: 테스트 환경 설정
2. **Act**: 테스트 대상 실행
3. **Assert**: 결과 검증

## Python (pytest) 예시
```python
import pytest
from unittest.mock import Mock, patch

class TestUserService:
    @pytest.fixture
    def user_service(self):
        """테스트용 서비스 인스턴스"""
        return UserService()
    
    @pytest.fixture
    def mock_db(self):
        """데이터베이스 목"""
        return Mock()
    
    async def test_create_user_success(self, user_service, mock_db):
        # Arrange
        user_data = {"email": "test@example.com", "name": "Test User"}
        mock_db.save.return_value = {"id": 1, **user_data}
        
        # Act
        result = await user_service.create_user(user_data, db=mock_db)
        
        # Assert
        assert result["id"] == 1
        assert result["email"] == user_data["email"]
        mock_db.save.assert_called_once()
```

## TypeScript (Jest) 예시
```typescript
describe('UserService', () => {
  let userService: UserService;
  let mockDb: jest.Mocked<Database>;
  
  beforeEach(() => {
    mockDb = createMockDb();
    userService = new UserService(mockDb);
  });
  
  describe('createUser', () => {
    it('should create user successfully', async () => {
      // Arrange
      const userData = { email: 'test@example.com', name: 'Test User' };
      mockDb.save.mockResolvedValue({ id: 1, ...userData });
      
      // Act
      const result = await userService.createUser(userData);
      
      // Assert
      expect(result.id).toBe(1);
      expect(result.email).toBe(userData.email);
      expect(mockDb.save).toHaveBeenCalledWith('users', userData);
    });
  });
});
```