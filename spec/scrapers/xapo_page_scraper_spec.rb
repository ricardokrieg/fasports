require './scrapers/xapo_page_scraper'

RSpec.describe XapoPageScraper do
  subject { XapoPageScraper.new('https://xapostore.com.br/produtos/page/7/?sort_by=created-descending&results_only=true&limit=12&theme=amazonas') }

  describe 'scrape', vcr: 'xapo_page_1' do
    it 'returns the page result' do
      expect(subject.scrape).to eq(nil)
    end
  end
end
