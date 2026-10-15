from unicodedata import category
import scrapy

class Helloscrapy03Item(scrapy.Item):
    category = scrapy.Field()
