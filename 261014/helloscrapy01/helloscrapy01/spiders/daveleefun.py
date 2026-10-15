import scrapy
from helloscrapy01.items import Helloscrapy01Item

class DaveleefunSpider(scrapy.Spider):
    name = "daveleefun"
    allowed_domains = ["davelee-fun.github.io"]
    start_urls = ["https://davelee-fun.github.io"]

    def parse(self, response):
        item = Helloscrapy01Item()
        item["title"] = response.css('h1.sitetitle::text').get()
        # 1) 예외조항처리 기법 : 코드가 길어지는 단점, strip() 대상이 존재하지 않을 것 까지 예상한 안전.보수코드
        description = response.xpath('//p[@class="lead"]/text()').get()
        if description :
            item["description"] = description.strip()
        else :
            item["description"] = ""
        # 2) Method Chaining 기법 : strip() 대상이 존재하지 않을 경우, 100% 에러
        # item["description"] = response.xpath('//p[@class="lead"]/text()').get().strip()
        yield item
