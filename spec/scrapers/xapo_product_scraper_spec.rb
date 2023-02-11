require './scrapers/xapo_product_scraper'
require './scrapers/models/variant'
require './scrapers/models/product'

RSpec.describe XapoProductScraper do
  subject { XapoProductScraper.new('https://xapostore.com.br/produtos/senegal-away-2020-2021/') }

  describe 'scrape', vcr: 'xapo_product' do
    it 'returns the scraped product' do
      product = Product.new({
        id: '81342743',
        name: 'Senegal - Away (2020/2021)',
        variants: [
          Variant.new({
            id: '315978811',
            price: 159.9,
            option: 'P',
            image_url: 'https://d3ugyf2ht6aenh.cloudfront.net/stores/001/482/519/products/26615f14-06dd-46f8-9f02-0ee100e25cd91-26ece61e68ccec5f5a16169974959915-1024-1024.webp',
          }),
          Variant.new({
            id: '315978812',
            price: 159.9,
            option: 'M',
            image_url: 'https://d3ugyf2ht6aenh.cloudfront.net/stores/001/482/519/products/26615f14-06dd-46f8-9f02-0ee100e25cd91-26ece61e68ccec5f5a16169974959915-1024-1024.webp',
          }),
          Variant.new({
            id: '315978813',
            price: 159.9,
            option: 'G',
            image_url: 'https://d3ugyf2ht6aenh.cloudfront.net/stores/001/482/519/products/26615f14-06dd-46f8-9f02-0ee100e25cd91-26ece61e68ccec5f5a16169974959915-1024-1024.webp',
          }),
          Variant.new({
            id: '315978814',
            price: 159.9,
            option: 'GG',
            image_url: 'https://d3ugyf2ht6aenh.cloudfront.net/stores/001/482/519/products/26615f14-06dd-46f8-9f02-0ee100e25cd91-26ece61e68ccec5f5a16169974959915-1024-1024.webp',
          }),
          Variant.new({
            id: '315978815',
            price: 159.9,
            option: 'XG',
            image_url: 'https://d3ugyf2ht6aenh.cloudfront.net/stores/001/482/519/products/26615f14-06dd-46f8-9f02-0ee100e25cd91-26ece61e68ccec5f5a16169974959915-1024-1024.webp',
          }),
          Variant.new({
            id: '315978816',
            price: 159.9,
            option: 'XXG',
            image_url: 'https://d3ugyf2ht6aenh.cloudfront.net/stores/001/482/519/products/26615f14-06dd-46f8-9f02-0ee100e25cd91-26ece61e68ccec5f5a16169974959915-1024-1024.webp',
          }),
        ]
      })
      expect(subject.scrape).to eq(product)
    end
  end
end
