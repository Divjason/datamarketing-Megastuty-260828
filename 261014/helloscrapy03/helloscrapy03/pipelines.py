from scrapy.exceptions import DropItem

class CleansingCategoryPipeline:
    def process_item(self, item, spider):
        item["category"] = item["category"].strip()
        return item

class SetPipeline:
    def __init__(self):
        self.categories_seen = set()
    
    def process_item(self, item, spider):
        if item["category"] in self.categories_seen :
            raise DropItem("Duplicate item found: %s" % item)
        else :
            self.categories_seen.add(item["category"])
            return item

class RemovePhrasePipeline:
    def process_item(self, item, spider):
        item["category"] = item["category"].replace(" 관련 상품 추천", "")
        return item