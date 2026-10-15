import scrapy

class Helloscrapy02Item(scrapy.Item):
    title = scrapy.Field()
    description = scrapy.Field()