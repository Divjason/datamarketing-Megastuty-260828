import os
import mysql.connector

from dotenv import load_dotenv
from fastapi import FastAPI, HTTPException

load_dotenv()

app = FastAPI(
  title="Wconcept MySQL API",
  description="FastAPI와 MySQL 직접 연결",
  version="1.0.0"
)

def get_db_connection() :

  return mysql.connector.connect(
    host=os.getenv("DB_HOST"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    database=os.getenv("DB_NAME")
  )

# 전체 상품 조회
@app.get("/products", status_code=200)
def get_products(limit: int = 10):

  # print(conn.is_connected()) # True
  conn = get_db_connection()
  cursor = conn.cursor(dictionary=True)

  # 실제 작업자 역할
  # 디폴트 값 => 향후 작업 후 반환하는 값의 형태를 튜플 : (a, b, c)
  # 가급적 객체형태로 가져오는 것이 유리함!
  # 파이썬 = 객체지향 프로그래밍 언어 : 문법 다양, 클라우드 컴퓨팅 서버배포

  cursor.execute(
    """
    SELECT
      product_id,
      brand_name,
      product_name,
      price
    FROM api_products
    LIMIT %s;
    """, (limit, )
  )

  products = cursor.fetchall()

  cursor.close()
  conn.close()

  if products is None:
    raise HTTPException(
      status_code=404,
      detail="Products not found"
    )

  return products

# 특정 상품 조회
@app.get("/products/{product_id}")
def get_product(product_id: int):

  conn = get_db_connection()
  cursor = conn.cursor(dictionary=True)

  cursor.execute(
    """
    SELECT
      product_id,
      brand_name,
      product_name,
      price
    FROM api_products
    WHERE product_id = %s;
    """, (product_id, )
  )

  product = cursor.fetchone()

  cursor.close()
  conn.close()

  if product is None:
    raise HTTPException(
      status_code=404,
      detail="Product not found"
    )

  return product

# 신규 상품 생성
@app.post("/products", status_code=201)
def create_product(product: dict):

  conn = get_db_connection()
  cursor = conn.cursor(dictionary=True)

  cursor.execute(
    """
    INSERT INTO api_products
      (brand_name, product_name, price)
    VALUES
      (%s, %s, %s)
    """, (
      product["brand_name"],
      product["product_name"],
      product["price"]
    )
  )

  conn.commit()

  product_id = cursor.lastrowid

  cursor.close()
  conn.close()

  return {
    "producd_id": product_id,
    **product
  }

  # *product : tuple // **product : dict

