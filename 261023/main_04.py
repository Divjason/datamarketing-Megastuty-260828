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

# 상품 DB 수정
@app.put("/products/{product_id}")
def update_product(product_id: int, product: dict) :

  conn = get_db_connection()
  cursor = conn.cursor()

  sql = """
    UPDATE api_products
    SET
      brand_name = %s,
      product_name = %s,
      price = %s
    WHERE product_id = %s
  """

  values = (
    product["brand_name"],
    product["product_name"],
    product["price"],
    product_id
  )

  cursor.execute(sql, values)

  conn.commit()

  if cursor.rowcount == 0:
    cursor.close()

    raise HTTPException(
      status_code=404,
      detail="Product not found"
    )
  
  cursor.close()

  return {
    "product_id": product_id,
    **product
  }

@app.patch("/products/{product_id}")
def patch_product(product_id: int, product: dict) :

    conn = get_db_connection()
    cursor = conn.cursor()

    if "brand_name" in product :

      cursor.execute(
        """
        UPDATE api_products
        SET brand_name = %s
        WHERE product_id = %s
        """, (product["brand_name"], product_id)
      )
    
    if "product_name" in product :

      cursor.execute(
        """
        UPDATE api_products
        SET product_name = %s
        WHERE product_id = %s
        """, (product["product_name"], product_id)
      )
    
    if "price" in product :

      cursor.execute(
        """
        UPDATE api_products
        SET price = %s
        WHERE product_id = %s
        """, (product["price"], product_id)
      )
    
    conn.commit()
    cursor.close()

    return {
      "message": "Product updated"
    }

# 1) SQL 문법을 꼭 반드시 알아야하는 것일까?
# > Python 언어 문법 > SQL 문법

# 2) SQL 문법을 사용하다보니 굳이 불필요하게 행 수가 매우 많아진다
# > 코딩 (사람) => 실수 => 복잡한, 불필요하게 많은 => 버그 발생 경우

@app.delete("/products/{product_id}")
def delete_product(product_id: int) :
  
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute(
      """
      DELETE FROM api_products
      WHERE product_id = %s
      """, (product_id, )
    )

    conn.commit()

    affected_rows = cursor.rowcount

    cursor.close()

    if affected_rows == 0 :
      raise HTTPException(
        status_code=404,
        detail="Product not found"
      )
    
    return None

# ORM = Object-Relational Mapping
# Python : Object(객체) 지향 언어
# SQL : 구조화된 질의 언어
# 서로 다른 세계의 언어를 비교적 대중적인 영역의 언어로 통일화
# 객체 > SQL
# 설치해야하는 라이브러리 모듈 = sqlalchemy