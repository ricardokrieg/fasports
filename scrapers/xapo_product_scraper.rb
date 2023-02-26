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
    uri = URI.open(product_url, 'User-Agent' => USER_AGENT)
    doc = Nokogiri::HTML(uri.read)
    json_text = /<script>dataLayer = (.*?)<\/script>.*/.match(doc.to_s)
    json = JSON.parse(json_text.captures.first)[0]

    product_id = json['idProduct']
    product_name = doc.css('h1.product-name').text.strip

    json_variants = json['listSku']
    variants = json_variants.map do |json_variant|
      Variant.new({
        id: json_variant['idSku'],
        price: json_variant['price'].to_f,
        option: /Tamanho:\ (.*)/.match(json_variant['nameSku']).captures.first,
      })
    end

    Product.new({
      id: product_id,
      name: product_name,
      variants: variants,
      images: doc.css('#product-wrapper img.swiper-lazy').map { _1.attr('data-src') }
    })
  end

  private

  def pick_best_image(images)
    images.sort_by do |image_url|
      /^.*\ (\d+)w$/.match(image_url).captures.first.to_i
    end.reverse.first.split.first.prepend('https:')
  end
end
