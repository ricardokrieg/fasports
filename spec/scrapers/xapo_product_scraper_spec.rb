require './scrapers/xapo_product_scraper'
require './scrapers/models/variant'
require './scrapers/models/product'

RSpec.describe XapoProductScraper do
  subject { XapoProductScraper.new('https://xapostore.com.br/produtos/pronta-entrega-messi-10-2014-15/') }

  describe 'scrape', vcr: 'xapo_product' do
    it 'returns the scraped product' do
      product = Product.new({
        id: '155459462',
        name: '[PRONTA ENTREGA] Messi #10 - (2014/15)',
        variants: [
          Variant.new({
            id: '588772731',
            price: 209.9,
            option: 'M',
            image_url: "https://d3ugyf2ht6aenh.cloudfront.net/stores/001/482/519/products/037a0752-608b-4e83-9e26-b45e2497b3b31-1feee904b19b4128a816752848908120-1024-1024.webp",
          }),
          Variant.new({
            id: '588772732',
            price: 209.9,
            option: 'G',
            image_url: "https://d3ugyf2ht6aenh.cloudfront.net/stores/001/482/519/products/037a0752-608b-4e83-9e26-b45e2497b3b31-1feee904b19b4128a816752848908120-1024-1024.webp",
          }),
        ],
        images: %w[
          https://d3ugyf2ht6aenh.cloudfront.net/stores/001/482/519/products/037a0752-608b-4e83-9e26-b45e2497b3b31-1feee904b19b4128a816752848908120-640-0.webp
          https://d3ugyf2ht6aenh.cloudfront.net/stores/001/482/519/products/c6dbc153-aa9a-45cf-8136-e237c711cc101-d4b1ac9c6af8fab42d16752848905615-640-0.webp
          https://d3ugyf2ht6aenh.cloudfront.net/stores/001/482/519/products/d39afa24-b036-4c54-88b9-60d1011a20001-0b84cd916fe4fc135816752848900595-640-0.webp
          https://d3ugyf2ht6aenh.cloudfront.net/stores/001/482/519/products/b53d152a-6344-4e38-975d-4cee93f717501-bc12a1954ac0b455e916752848907001-640-0.webp
          https://d3ugyf2ht6aenh.cloudfront.net/stores/001/482/519/products/38fa1e7f-e8bb-4b06-b854-d95376390d741-72f2d48abf0b4188f716752848900831-640-0.webp
        ]
      })
      expect(subject.scrape).to eq(product)
    end
  end
end
