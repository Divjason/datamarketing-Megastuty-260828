import scrapy
import time

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager


class SeleniumTestSpider(scrapy.Spider):
    name = "selenium_test"
    allowed_domains = ["selenium-testsite-250723.netlify.app"]
    start_urls = ["https://selenium-testsite-250723.netlify.app/"]

    def __init__(self):
        service = Service(ChromeDriverManager().install())
        options = Options()
        options.add_argument("--window-size=1920, 1080")
        options.add_argument("--lang=ko-KR")
        options.add_argument("--headless")

        self.driver = webdriver.Chrome(service=service, options=options)

    def parse(self, response):
        self.driver.get(response.url)
        time.sleep(2)
        
        element = self.driver.find_element(By.CSS_SELECTOR, "span.news")

        yield {
            "news": element.text
        }
    def closed(self):
        self.driver.quit()
