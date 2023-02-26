class XapoMultipleProductsScraper
  def initialize(products)
    @products = products
  end

  def scrape
    threads = []
    products.each do |product|
      threads << Thread.new { XapoProductScraper.new(product.url).scrape }
    end
    threads.each(&:join)

    threads.map(&:value)
  end

  private

  attr_reader :products
end