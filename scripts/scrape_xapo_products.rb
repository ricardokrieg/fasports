require 'ostruct'

URL = 'https://xapostore.com.br/produtos/page/7/?sort_by=created-descending&results_only=true&limit=12&theme=amazonas'
config = OpenStruct.new(per_page: 100)

scraper = XapoScraper.new

scraper.scrape
