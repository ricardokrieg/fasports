require './scrapers/xapo_multiple_products_scraper'
require './scrapers/xapo_product_scraper'
require './scrapers/models/product'
require './scrapers/models/page_result_product'

RSpec.describe XapoMultipleProductsScraper do
  subject { described_class.new(product_results) }

  let(:product_results) do
    [
      PageResultProduct.new(id: 1, url: 'http://example.com/1'),
      PageResultProduct.new(id: 2, url: 'http://example.com/2'),
    ]
  end

  describe 'scrape' do
    let(:scraped_product_1) { Product.new({ id: '1', name: 'Test 1', variants: [], images: [] }) }
    let(:scraped_product_2) { Product.new({ id: '2', name: 'Test 2', variants: [], images: [] }) }

    before do
      product_scraper_1 = double(XapoProductScraper)
      allow(XapoProductScraper).to receive(:new).with(product_results[0].url).and_return product_scraper_1
      allow(product_scraper_1).to receive(:scrape).and_return scraped_product_1

      product_scraper_2 = double(XapoProductScraper)
      allow(XapoProductScraper).to receive(:new).with(product_results[1].url).and_return product_scraper_2
      allow(product_scraper_2).to receive(:scrape).and_return scraped_product_2
    end

    it 'returns the scraped products' do
      expect(subject.scrape).to eq([ scraped_product_1, scraped_product_2 ])
    end
  end
end
