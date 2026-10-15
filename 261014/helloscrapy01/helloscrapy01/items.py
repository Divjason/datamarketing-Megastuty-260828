import scrapy

class Helloscrapy01Item(scrapy.Item):
    title = scrapy.Field()
    description = scrapy.Field()