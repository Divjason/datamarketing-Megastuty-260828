from itemadapter import ItemAdapter
from scrapy.exceptions import DropItem

class Helloscrapy02Pipeline:
    def process_item(self, item):
        if item["description"] :
            item["description"] = item["description"].strip()
            return item
        else :
            raise DropItem("Missing description in %s" % item)
