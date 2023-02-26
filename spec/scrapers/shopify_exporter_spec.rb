require './exporters/shopify_exporter'
require './scrapers/models/product'
require './scrapers/models/variant'

RSpec.describe ShopifyExporter do
  subject { described_class.new(products) }

  Variant = Struct.new(:id, :price, :option, :image_url, keyword_init: true)
  let(:products) { [
    Product.new(id: '1', name: 'Test 1', variants: [
      Variant.new(id: '11', price: 12.34, option: 'A', image_url: 'http://example.com/image11.jpg'),
      Variant.new(id: '12', price: 0.5, option: 'B', image_url: 'http://example.com/image12.jpg'),
    ], images: %w[http://example.com/image1_1.jpg http://example.com/image1_2.jpg]),
    Product.new(id: '2', name: 'Test 2', variants: [], images: []),
  ] }

  describe 'export_to' do
    it 'exports the products to the given IO object' do
      io = StringIO.new

      expected = [
        ["", "com-variacao", "", "XP1", "S", "N", "", "", "Test 1", "Test 1", "", "", "", "", "", "N", "", "", "", "", "", "", "", "", "Categoria 1", "Categoria 2", "", "", "", "http://example.com/image1_1.jpg", "http://example.com/image1_2.jpg", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""],
        ["", "variacao", "XP1", "XP1-A", "S", "N", "", "", "", "", "", "N", "", "imediata", "30 dias", "N", "", 12.34, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "A", ""],
        ["", "variacao", "XP1", "XP1-B", "S", "N", "", "", "", "", "", "N", "", "imediata", "30 dias", "N", "", 0.5, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "B", ""],
        ["", "com-variacao", "", "XP2", "S", "N", "", "", "Test 2", "Test 2", "", "", "", "", "", "N", "", "", "", "", "", "", "", "", "Categoria 1", "Categoria 2", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""],
      ].reduce('') do |acc, row|
        acc += row.to_s
      end

      expect { subject.export_to(io) }.to change { io.string }.to expected.to_s
    end
  end
end
