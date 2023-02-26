require 'ostruct'

require './scrapers/xapo_scraper'
require './scrapers/models/scrape_config'

URL = 'https://xapostore.com.br/produtos/page/<PAGE>/?sort_by=created-descending&results_only=true&limit=<PER_PAGE>&theme=amazonas'
config = ScrapeConfig.new(initial_page: 50, per_page: 12)

XapoScraper.new(URL, config).scrape
