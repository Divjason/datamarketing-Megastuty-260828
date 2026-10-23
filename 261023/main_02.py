from fastapi import FastAPI, HTTPException

# API Metadata 설정
app = FastAPI(
  title="Wconcept API",
  description="Wconcept 상품 및 리뷰 데이터 API",
  version="1.0.0"
)

# 임시 DB
products = [
  {
    "product_id": 1,
    "product_name": "Wconcept Jacket",
    "price": 129000
  },
  {
    "product_id": 2,
    "product_name": "Wconcept Bag",
    "price": 89000
  }
]

# Path Parameter 존재하지 않는 경우!
@app.get("/")
def home():
  return {
    "message": "Hello Wconcept"
  }

# Path Parameter 존재하는 경우!
@app.get("/hello")
def hello():
  return {
    "message": "FastAPI Start!"
  }

@app.get("/products")
def get_products(
  limit: int = 10,
  brand: str | None = None # 전자 : 값이 없음을 의미하는 파이썬 객체, 후자 : 인자값이 없을 때를 위해서 사용할 기본값
):
  return {
    "limit": limit,
    "brand": brand
  }

# http://127.0.0.1:8000/products/1
# 오타, 문법 -> 값이 없어서, 서버 문제
@app.get("/products/{product_id}")
def get_product(product_id: int):

  for product in products :

    if product["product_id"] == product_id :
      return product

  raise HTTPException(
    status_code=404,
    detail="해당 상품을 찾을 수 없습니다."
  )

# 외부에서 우리가 제공하는 형태의 값이 어떤 방식으로 구현되고 있는지 관심 // 테스트
# Swagger UI : FastAPI 제공 인터페이스
# http://127.0.0.1:8000/docs : Try it out : 테스트
# http://127.0.0.1:8000/redoc : Manual : 문서확인