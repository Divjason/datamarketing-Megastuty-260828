from fastapi import FastAPI

app = FastAPI()

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

# 고정 Path Parameter
# @app.get("/products")
# def get_products():
#   return {
#     "products": [
#       {
#         "product_id": "P001",
#         "product_name": "Wconcept Jacket",
#         "price": 129000
#       },
#             {
#         "product_id": "P002",
#         "product_name": "Wconcept Bag",
#         "price": 89000
#       },
#     ]
#   }

# Path Parameter : /파라미터변수 (유무에 따라서 보여주는 값이 상이함)
# 단일 Query Parameter = Query String : ? (경로와 무관, 옵셔널한 매개변수)
# http://127.0.0.1:8000/products?limit=5
# @app.get("/products")
# def get_products(limit: int = 10):
#   return {
#     "limit": limit
#   }

# 가변 Path Parameter
# @app.get("/products/{product_id}") vs @app.get("/product/{product_id}")
# def get_product(product_id):
#   return {
#     "product_id": product_id
#   }

# Path Parameter + 복수 Query Parameter
# https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=치카와&ackey=hhcxvaut

# http://127.0.0.1:8000/products?limit=7&brand=wconcept
@app.get("/products")
def get_products(
  limit: int = 10,
  brand: str | None = None # 전자 : 값이 없음을 의미하는 파이썬 객체, 후자 : 인자값이 없을 때를 위해서 사용할 기본값
):
  return {
    "limit": limit,
    "brand": brand
  }

# 가변 Path Parameter + Type Hint 적용
@app.get("/products/{product_id}")
def get_product(product_id: int):
  return {
    "product_id": product_id
  }
