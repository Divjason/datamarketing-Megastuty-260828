from fastapi import FastAPI, HTTPException, Response

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
    "brand_name": "RECTO",
    "product_name": "Jacket",
    "price": 129000
  },
  {
    "product_id": 2,
    "brand_name": "LOW CLASSIC",
    "product_name": "Bag",
    "price": 89000
  },
  {
    "product_id": 3,
    "brand_name": "MARDI",
    "product_name": "T-Shirt",
    "price": 59000
  }
]


@app.get("/products")
def get_products():
  return products

@app.get("/products/{product_id}")
def get_product(product_id: int):

  for product in products :

    if product["product_id"] == product_id :
      return product

  raise HTTPException(
    status_code=404,
    detail="Product not found"
  )

@app.post("/products", status_code=201)
def create_product(product: dict):
  products.append(product)

  return product

# Resource 전체 상태를 교체하는 수정
@app.put("/products/{product_id}", status_code=201)
def update_product(
  product_id: int,
  new_product: dict
):

  for index, product in enumerate(products):

    if product["product_id"] == product_id:

      new_product["product_id"] = product_id

      products[index] = new_product

      return new_product
  
  raise HTTPException(
    status_code=404,
    detail="Product not found"
  )

# Resource 일부 상태를 교체하는 수정
@app.patch("/products/{product_id}")
def patch_product(
  product_id: int,
  updated_data: dict
):
  for product in products:

    if product["product_id"] == product_id:

      product.update(updated_data)

      return product
  
  raise HTTPException(
    status_code=401,
    detail="Product not found"
  )

@app.delete(
  "/products/{product_id}",
  status_code=204
)
def delete_product(product_id: int):

  for index, product in enumerate(products):

    if product["product_id"] == product_id:
      
      products.pop(index)

      return Response(status_code=204)
  
  raise HTTPException(
    status_code=404,
    detail="Product not found"
  )