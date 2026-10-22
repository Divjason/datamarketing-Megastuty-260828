import scrapy

class ProductItem(scrapy.Item):

    item_type = scrapy.Field()

    rank = scrapy.Field()
    product_id = scrapy.Field()

    brand_id = scrapy.Field()
    brand_name_kr = scrapy.Field()
    brand_name_en = scrapy.Field()

    product_name = scrapy.Field()

    category_1 = scrapy.Field()
    category_2 = scrapy.Field()
    category_3 = scrapy.Field()

    customer_price = scrapy.Field()
    sale_price = scrapy.Field()
    final_price = scrapy.Field()
    discount_rate = scrapy.Field()

    review_count = scrapy.Field()
    review_score = scrapy.Field()

    heart_count = scrapy.Field()

    product_url = scrapy.Field()
    image_url = scrapy.Field()

class ReviewItem(scrapy.Item):

    product_id = scrapy.Field()

    review_id = scrapy.Field()

    rating = scrapy.Field()

    review_text = scrapy.Field()

    created_at = scrapy.Field()

    review_articles = scrapy.Field()

    review_options = scrapy.Field()

    review_images = scrapy.Field()