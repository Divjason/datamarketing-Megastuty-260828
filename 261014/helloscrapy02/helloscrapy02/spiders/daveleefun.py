import scrapy
from helloscrapy02.items import Helloscrapy02Item

class DaveleefunSpider(scrapy.Spider):
    name = "daveleefun"
    allowed_domains = ["davelee-fun.github.io"]
    start_urls = ["https://davelee-fun.github.io"]

    def parse(self, response):
        item = Helloscrapy02Item()
        item["title"] = response.css('h1.sitetitle::text').get()
        item["description"] = response.xpath('//p[@class="lead"]/text()').get()
        yield item