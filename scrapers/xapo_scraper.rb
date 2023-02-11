require 'open-uri'
require 'nokogiri'
require 'ostruct'

require_relative './models/variant'
require_relative './models/product'

USER_AGENT = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36'

class XapoScraper
  private attr_reader :url

  def initialize(url)
    @url = url
  end

  def scrape
    doc = Nokogiri::HTML(URI.open(product_url, 'User-Agent' => USER_AGENT))
  end
end
