require 'open-uri'
require 'nokogiri'

require_relative './models/page_result'

USER_AGENT = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36'

class XapoPageScraper
  private attr_reader :url

  def initialize(url)
    @url = url
  end

  def scrape
    uri = URI.open(url, 'User-Agent' => USER_AGENT, 'Accept' => 'application/json')
    json = JSON.parse(uri.read)
    doc = Nokogiri::HTML(json['html'])

    x = []
    doc.search('[data-product-id]').each do |product|
      x << OpenStruct.new(id: product.attr('data-product-id'), url: product.search('a').first.attr('href'))
    end

    x

    # unless json[:has_results]
    #   return PageResult.new(has_results: false, has_next: false)
    # end

    # PageResult.new(has_results: json[:has_results], has_next: json[:has_next])
    nil
  end
end
