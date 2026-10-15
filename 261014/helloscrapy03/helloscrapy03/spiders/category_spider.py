import scrapy
from helloscrapy03.items import Helloscrapy03Item

class CategorySpiderSpider(scrapy.Spider):
    name = "category_spider"
    allowed_domains = ["davelee-fun.github.io"]
    start_urls = ["https://davelee-fun.github.io"]

    def parse(self, response):
        categories = response.css('a.text-dark::text').getall()
        for category in categories :
            item = Helloscrapy03Item()
            item["category"] = category
            yield item