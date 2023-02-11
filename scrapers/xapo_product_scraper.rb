require 'open-uri'
require 'nokogiri'

require_relative './models/variant'
require_relative './models/product'

USER_AGENT = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36'

class XapoProductScraper
  private attr_reader :product_url

  def initialize(product_url)
    @product_url = product_url
  end

  def scrape
    doc = Nokogiri::HTML(URI.open(product_url, 'User-Agent' => USER_AGENT))

    variants_text = /LS\.variants\ =\ \[(.*?)\];.*/.match(doc.text)
    product_text = /LS\.product\ =\ {(.*?)};.*/m.match(doc.text)

    variants_attrs = eval(variants_text.captures.first.tr("\n ", '').gsub('null', 'nil').prepend('[').concat(']'))
    variants = variants_attrs.map do |variant_attrs|
      Variant.new({
        id: variant_attrs[:id].to_s,
        price: variant_attrs[:price_number],
        option: variant_attrs[:option0],
        image_url: variant_attrs[:image_url].prepend('https:'),
      })
    end

    product_attrs = eval(product_text.captures.first.tr("\n ", '').prepend('{').concat('}'))
    Product.new({
      id: product_attrs[:id].to_s,
      name: replace_hex_chars(product_attrs[:name]),
      variants: variants,
    })
  end

  private

  # "\x20\x2D" -> " -"
  def replace_hex_chars(name)
    name.gsub(/\\x(.{2})/) { [Regexp.last_match[1]].pack('H*') }
  end
end
