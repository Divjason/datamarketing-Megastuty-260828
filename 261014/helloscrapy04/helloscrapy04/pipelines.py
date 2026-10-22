class CleanTitlePipeline:
    def process_item(self, item):
        item["title"] = item["title"].replace("상품명: ", "")
        item["title"] = item["title"].strip()
        return item
