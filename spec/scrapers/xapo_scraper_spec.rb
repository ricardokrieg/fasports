require './scrapers/xapo_scraper'
require './scrapers/xapo_multiple_products_scraper'
require './exporters/shopify_exporter'
require './scrapers/models/scrape_config'

RSpec.describe XapoScraper do
  subject { described_class.new(url, config) }

  let(:url) { 'http://example.com/page/<PAGE>/' }
  let(:config) { ScrapeConfig.new(initial_page: 1, per_page: 100) }
  let(:page_results) { PageResult.new(has_results: true, has_next: false, products: [page_result_product]) }
  let(:page_result_product) { PageResultProduct.new(id: 1, url: 'http://example.com/product/1') }
  let(:products) { [] }
  let(:io) { StringIO.new }
  let(:xapo_page_scraper) { double(XapoPageScraper) }
  let(:xapo_multiple_products_scraper) { double(XapoMultipleProductsScraper) }
  let(:shopify_exporter) { double(ShopifyExporter) }

  before do
    allow(XapoPageScraper).to receive(:new).with('http://example.com/page/1/').and_return(xapo_page_scraper)
    allow(XapoMultipleProductsScraper).to receive(:new).with([page_result_product]).and_return(xapo_multiple_products_scraper)
    allow(ShopifyExporter).to receive(:new).with(products).and_return(shopify_exporter)
    allow(CSV).to receive(:open).and_yield(io)
  end

  describe 'scrape', vcr: 'xapo_page_1' do
    it 'scrapes all available pages' do
      expect(xapo_page_scraper).to receive(:scrape).and_return(page_results)
      expect(xapo_multiple_products_scraper).to receive(:scrape).and_return(products)
      expect(shopify_exporter).to receive(:export_to).with(io)

      subject.scrape
    end
  end
end
