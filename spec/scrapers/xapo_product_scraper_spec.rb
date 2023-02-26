require './scrapers/xapo_product_scraper'
require './scrapers/models/variant'
require './scrapers/models/product'

RSpec.describe XapoProductScraper do
  subject { XapoProductScraper.new('https://www.xapostore.com.br/masculinas/versao-torcedor/selecoes/escocia-aniversario-150-anos') }

  describe 'scrape', vcr: 'xapo_product' do
    it 'returns the scraped product' do
      product = Product.new({
        id: '1125',
        name: 'Escócia - Aniversário 150 anos',
        variants: [
          Variant.new({
            id: '1125-5659',
            price: 159.9,
            option: 'P',
            image_url: nil,
          }),
          Variant.new({
            id: '1125-5661',
            price: 159.9,
            option: 'M',
            image_url: nil,
          }),
          Variant.new({
            id: '1125-5663',
            price: 159.9,
            option: 'G',
            image_url: nil,
          }),
          Variant.new({
            id: '1125-5665',
            price: 159.9,
            option: 'GG',
            image_url: nil,
          }),
          Variant.new({
            id: '1125-5667',
            price: 159.9,
            option: '2GG',
            image_url: nil,
          }),
        ],
        images: %w[
          https://images.tcdn.com.br/img/img_prod/1183067/escocia_aniversario_150_anos_1125_1_e7d1cc07eb814b0769e10bf9262f906f.jpg
          https://images.tcdn.com.br/img/img_prod/1183067/escocia_aniversario_150_anos_1125_2_a28fad708b19ce0891404638323b8ad8.jpeg
          https://images.tcdn.com.br/img/img_prod/1183067/escocia_aniversario_150_anos_1125_3_8763301ec74caf1539c9663dc3903930.jpg
          https://images.tcdn.com.br/img/img_prod/1183067/escocia_aniversario_150_anos_1125_4_dc0d2e204668ae75940745f9c07c585c.jpg
          https://images.tcdn.com.br/img/img_prod/1183067/escocia_aniversario_150_anos_1125_5_156318da8f59b628eb59afe2d6efa94a.jpg
          https://images.tcdn.com.br/img/img_prod/1183067/escocia_aniversario_150_anos_1125_6_5506e40d027718f9d91a8b2d66be9304.jpg
          https://images.tcdn.com.br/img/img_prod/1183067/escocia_aniversario_150_anos_1125_7_be78cdcb00423b169f1931a7a9e99287.jpg
          https://images.tcdn.com.br/img/img_prod/1183067/escocia_aniversario_150_anos_1125_8_9cb0d608dde5083624f35ec98cb8f2fd.jpg
        ]
      })
      expect(subject.scrape).to eq(product)
    end
  end
end
