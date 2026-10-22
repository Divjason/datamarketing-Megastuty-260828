import os
import scrapy

from scrapy.http import JsonRequest
from scrapy.extensions.feedexport import ItemFilter

from dotenv import load_dotenv
from pathlib import Path

from wconcept.items import ProductItem, ReviewItem

ENV_PATH = Path(__file__).resolve().parents[2] / ".env"
load_dotenv(ENV_PATH)

class ProductItemFilter(ItemFilter):
    def accepts(self, item):
        return isinstance(item, ProductItem)

class ReviewItemFilter(ItemFilter):
    def accepts(self, item):
        return isinstance(item, ReviewItem)

def feed_uri_params(params, spider) :
    params["batch"] = f"{spider.start_rank:03d}_{spider.end_rank:03d}"

class ProductsSpider(scrapy.Spider):

    def __init__(self, start_rank=1, end_rank=100, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.start_rank = int(start_rank)
        self.end_rank = int(end_rank)

    name = "products"

    allowed_domains = [
        "display.wconcept.co.kr",
        "gw-front.wconcept.co.kr",
        "gw-backend.wconcept.co.kr",
        "www.wconcept.co.kr"
    ]
    
    BEST_API_URL = "https://gw-front.wconcept.co.kr/display/api/best/v1/product"

    TARGET_COUNT = 200
    REVIEW_LIMIT = 20
    REVIEW_PAGE_SIZE = 20

    AUTHORIZATION = os.getenv("WCONCEPT_REVIEW_AUTHORIZATION")

    API_HEADERS = {
        "accept": "*/*",
        "accept-language": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7",
        "agegroup": "",
        "birthdate": "",
        "cache-control": "no-cache",
        "content-type": "application/json; charset=utf-8",
        "devicetype": "PC",
        "display-api-key": os.getenv("WCONCEPT_DISPLAY_API_KEY", ""),
        "gendertype": "ALL",
        "membergrade": "8",
        "origin": "https://display.wconcept.co.kr",
        "pragma": "no-cache",
        "profileseqno": "",
        "referer": "https://display.wconcept.co.kr/",
        "user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36"
    }

    async def start(self):

        payload = {
            "ageGroup": "all",
            "custNo": "0",
            "dateType": "daily",
            "depth1Code": "ALL",
            "depth2Code": "ALL",
            "domain": "WOMEN",
            "genderType": "all",
            "pageNo": 1,
            "pageSize": self.TARGET_COUNT
        }

        self.logger.info(
            f"BEST 상품 {self.TARGET_COUNT}개 요청 준비!"
        )

        yield JsonRequest(
            url=self.BEST_API_URL,
            method="POST",
            headers=self.API_HEADERS,
            data=payload,
            callback=self.parse_best
        )

    def parse_best(self, response):
        data = response.json()
        content = data.get("data", {}).get("content", [])

        if content :
            product_data = content[0]

            print("첫 번째 상품 자료형:", type(product_data))
            print("첫 번째 상품 key:", product_data.keys())
            print("상품 ID:", product_data.get("itemCd"))
            print("브랜드명:", product_data.get("brandNameKr"))
            print("상품명:", product_data.get("itemName"))
            print("판매가격:", product_data.get("salePrice"))

        all_products = content[:self.TARGET_COUNT]

        products = all_products[self.start_rank - 1:self.end_rank]

        for rank, product_data in enumerate(products, start=self.start_rank) :
            product = ProductItem()

            product["item_type"] = "product"

            product["rank"] = rank

            product["product_id"] = product_data.get("itemCd")

            product["brand_id"] = product_data.get("brandCd")

            product["brand_name_kr"] = product_data.get("brandNameKr")

            product["brand_name_en"] = product_data.get("brandNameEn")

            product["product_name"] = product_data.get("itemName")

            product["category_1"] = product_data.get("categoryDepthName1")

            product["category_2"] = product_data.get("categoryDepthName2")

            product["category_3"] = product_data.get("categoryDepthName3")

            product["customer_price"] = product_data.get("customerPrice")

            product["sale_price"] = product_data.get("salePrice")

            product["final_price"] = product_data.get("finalPrice")

            product["discount_rate"] = product_data.get("finalDiscountRate")

            product["review_count"] = product_data.get("reviewCnt")

            product["review_score"] = product_data.get("reviewScore")

            product["heart_count"] = product_data.get("heartCnt")

            product["product_url"] = product_data.get("landingUrl")
            
            product["image_url"] = product_data.get("productImageUrl")

            yield product

            review_count = product_data.get("reviewCnt") or 0

            self.logger.info(f"[리뷰 확인] rank={rank} | review_count={review_count}")

            if review_count == 0 :
                continue

            item_cd = product["product_id"]

            detail_url = f"https://www.wconcept.co.kr/Product/{item_cd}"

            self.logger.info(f"[상세페이지 요청] rank={rank} | URL={detail_url}")

            yield scrapy.Request(
                url=detail_url,
                callback=self.parse_product,
                cb_kwargs={
                    "rank": rank,
                    "product_id": item_cd,
                    "review_count": review_count
                },
                headers=self.API_HEADERS
            )
    
    def parse_product(self, response, rank, product_id, review_count):
        item_cd = response.css("#qa_itemcd::attr(value)").get()
        medium_cd = response.css("#mcd::attr(value)").get()
        category_cd = response.css("#ca::attr(value)").get()

        self.logger.info(f"[상세정보] rank={rank} | product_id={product_id} | itemCd={item_cd} | mediumCd={medium_cd} | categoryCd={category_cd} | review_count={review_count}")

        review_request = self.make_review_request(
            item_cd=item_cd,
            medium_cd=medium_cd,
            category_cd=category_cd,
            product_id=product_id,
            rank=rank,
            page_no=1
        )

        if review_request is not None :
            yield review_request
    
    def make_review_request(self, item_cd, medium_cd, category_cd, product_id, rank, page_no):

        review_url = "https://gw-backend.wconcept.co.kr/api/v2/review/tab/list/with-summary"

        payload = {
            "categoryCd": category_cd,
            "hiddenReviewInclude": True,
            "itemCd": item_cd,
            "itemTypeCd": "17",
            "mediumCd": medium_cd,
            "pageNo": page_no,
            "pageSize": self.REVIEW_PAGE_SIZE,
            "searchType": 1
        }

        headers = {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Origin": "https://www.wconcept.co.kr",
            "Referer": "https://www.wconcept.co.kr/",
            "User-Agent": self.API_HEADERS["user-agent"],
        }

        headers["X-Authorization"] = self.AUTHORIZATION

        self.logger.info(
            f"[리뷰 API 요청] rank={rank} | product_id={product_id} | page={page_no}"
        )

        return JsonRequest(
            url=review_url,
            method="POST",
            headers=headers,
            data=payload,
            callback=self.parse_reviews,
            cb_kwargs={
                "rank": rank,
                "product_id": product_id,
                "page_no": page_no
            }
        )
    
    def parse_reviews(self, response, rank, product_id, page_no):
        
        self.logger.info(
            f"[리뷰 API 응답] rank={rank} | HTTP={response.status}"
        )

        result = response.json()

        data = result.get("data") or {}

        reviews = data.get("reviews") or []
        review_total = data.get("reviewTotal", 0)
        total_pages = data.get("reviewTotalPages", 0)

        self.logger.info(
            f"[리뷰 수집 성공] rank={rank} | product_id={product_id} | page={page_no} | total={review_total} | total_pages={total_pages} | recevied={len(reviews)}"
        )

        for review in reviews[0:self.REVIEW_LIMIT]:

            item = ReviewItem()

            item["product_id"] = product_id

            item["review_id"] = review.get("reviewMasterSeqNo")

            item["rating"] = review.get("reviewRating")

            item["review_text"] = review.get("contents")

            item["created_at"] = review.get("reviewRegDate")

            item["review_articles"] = review.get("reviewArticles", [])

            item["review_options"] = review.get("reviewOptions", [])

            item["review_images"] = [file.get("filePath") for file in review.get("reviewFiles", [])]

            yield item

            self.logger.info(
                f"[리뷰 저장] product_id={product_id} | review_id={item['review_id']}"
            )

    @classmethod
    def update_settings(cls, settings) :
        super().update_settings(settings)

        settings.set(
            "FEED_URI_PARAMS",
            feed_uri_params,
            priority="spider"
        )

        settings.set(
            "FEEDS",
            {
                    "products_%(batch)s.json": {
                    "format": "json",
                    "encoding": "utf-8",
                    "overwrite": True,
                    "item_filter": ProductItemFilter
                },
                    "reviews_%(batch)s.json": {
                    "format": "json",
                    "encoding": "utf-8",
                    "overwrite": True,
                    "item_filter": ReviewItemFilter
                }
            },
            priority="spider"
        )
