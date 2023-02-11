require './scrapers/xapo_page_scraper'
require './scrapers/models/page_result'
require './scrapers/models/page_result_product'

RSpec.describe XapoPageScraper do
  subject { XapoPageScraper.new('https://xapostore.com.br/produtos/page/1/?sort_by=created-descending&results_only=true&limit=12&theme=amazonas') }

  describe 'scrape', vcr: 'xapo_page_1' do
    it 'returns the page result' do
      page_result = PageResult.new(
        has_results: true,
        has_next: true,
        products: [
          PageResultProduct.new(id: '156497469', url: 'https://xapostore.com.br/produtos/vasco-feminino-third-kit-2022-231/'),
          PageResultProduct.new(id: '156496998', url: 'https://xapostore.com.br/produtos/vasco-feminino-third-kit-2022-23/'),
          PageResultProduct.new(id: '156471146', url: 'https://xapostore.com.br/produtos/uruguai-away-2022-23/'),
          PageResultProduct.new(id: '156350852', url: 'https://xapostore.com.br/produtos/al-hilal-home-2022-23/'),
          PageResultProduct.new(id: '156309166', url: 'https://xapostore.com.br/produtos/iza/'),
          PageResultProduct.new(id: '155993570', url: 'https://xapostore.com.br/produtos/psg-third-kit-black-2017-18/'),
          PageResultProduct.new(id: '155629175', url: 'https://xapostore.com.br/produtos/lancamento-gremio-azul-celeste-2022-23/'),
          PageResultProduct.new(id: '155614640', url: 'https://xapostore.com.br/produtos/fluminense-camisa-de-goleiro-2022-23/'),
          PageResultProduct.new(id: '155613563', url: 'https://xapostore.com.br/produtos/sampdoria-home-2022-23/'),
          PageResultProduct.new(id: '155613234', url: 'https://xapostore.com.br/produtos/vasco-third-kit-black-2022-23/'),
          PageResultProduct.new(id: '155462162', url: 'https://xapostore.com.br/produtos/real-madrid-retro-2017-18/'),
          PageResultProduct.new(id: '155459462', url: 'https://xapostore.com.br/produtos/pronta-entrega-messi-10-2014-15/'),
        ]
      )

      expect(subject.scrape).to eq(page_result)
    end
  end
end
