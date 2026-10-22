from fastapi import FastAPI

app = FastAPI()

# Endpoint : 첫번째 엔드포인트
# 사용자의 요청이 무엇이들어올지 아무도 예측할 수 없음
# 사용자의 요청이 들어왔을 때, 그것을 응대할 수 있도록 설정해놓은 지점 = 엔드포인트
# 사용자가 get이라는 방식의 요청 : 그 요청에 맞춰서 값을 제공해줄게!
# get이라는 방식으로 데이터 요청 -> 요청을한 위치, 주소에 따라서 값을 다르게 줄 수 있음

@app.get("/")
def home():
  return {
    "message": "Hello Wconcept"
  }

@app.get("/hello")
def hello():
  return {
    "message": "FastAPI Start!"
  }

@app.get("/products")
def get_products():
  return {
    "products": [
      {
        "product_id": "P001",
        "product_name": "Wconcept Jacket",
        "price": 129000
      },
      {
        "product_id": "P002",
        "product_name": "Wconcept Bag",
        "price": 89000
      }
    ]
  }

@app.get("/products/{product_id}")
def get_products(product_id: str):
  return {
    "product_id": product_id
  }