require 'csv'

require_relative './xapo_page_scraper'
require_relative './xapo_multiple_products_scraper'

class XapoScraper
  def initialize(url, config)
    @url = url
    @config = config
  end

  def scrape
    page = config.initial_page
    loop do
      puts "Scraping page #{page}"
      puts page_url(page)

      page_result = XapoPageScraper.new(page_url(page)).scrape
      puts "Page #{page} returned #{page_result.products.size} products"

      products = XapoMultipleProductsScraper.new(page_result.products).scrape

      CSV.open('test.csv', 'a') do |csv|
        ShopifyExporter.new(products).export_to(csv)
      end

      break unless page_result.has_next

      page += 1
    end
  end

  private

  attr_reader :url, :config

  def page_url(page)
    url.gsub('<PAGE>', page.to_s).gsub('<PER_PAGE>', config.per_page.to_s)
  end
end
