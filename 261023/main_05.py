import os

from fastapi import FastAPI
from dotenv import load_dotenv

from sqlalchemy import create_engine, text, Integer, String
from sqlalchemy.orm import DeclarativeBase, sessionmaker, Mapped, mapped_column

# sqlalchemy : engine, session, model
# engine : 데이터 입.출력 관리하는 물리적인 역할담당
# session : engine이 문제없이 설정되었다는 전제, 실제 데이터 입.출력 역할
# model : 실제 값 적용 시, 타입 및 포맷에 맞춰서 입.출력 될 수 있도록 지원

load_dotenv()

app = FastAPI(
  title="Wconcept MySQL API",
  description="FastAPI와 MySQL 직접 연결",
  version="1.0.0"
)

# mysql+mysqlconnector://root:password@localhost/api_db

DATABASE_URL = (
  f"mysql+mysqlconnector://"
  f"{os.getenv("DB_USER")}:"
  f"{os.getenv("DB_PASSWORD")}@"
  f"{os.getenv("DB_HOST")}/"
  f"{os.getenv("DB_NAME")}"
)

engine = create_engine(DATABASE_URL)

# with engine.connect() as connection :
#   result = connection.execute(
#     text("SELECT 1")
#   )

#   print(result.fetchone())

SessionLocal = sessionmaker(
  bind=engine
)

class Base(DeclarativeBase):
  pass

class Product(Base):
  __tablename__ = "api_products"

  product_id: Mapped[int] = mapped_column(Integer, primary_key=True)

  brand_name: Mapped[str] = mapped_column(String(100))

  product_name: Mapped[str] = mapped_column(String(255))

  price: Mapped[int] = mapped_column(Integer)

@app.get("/products")
def get_products():

  db = SessionLocal()

  products = db.query(Product).all()

  db.close()

  return products
