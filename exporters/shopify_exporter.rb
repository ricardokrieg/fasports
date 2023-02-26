class ShopifyExporter
  def initialize(products)
    @products = products
  end

  def export_to(io)
    products.each do |product|
      export(product).each do |row|
        io << row
      end
    end
  end

  private

  attr_reader :products

  def export(product)
    sku = "XP#{product.id}"
    product_csv = [
      '',
      'com-variacao',
      '',
      sku,
      'S',
      'N',
      '',
      '',
      product.name,
      product.name,
      '',
      '',
      '',
      '',
      '',
      'N',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      'Categoria 1',
      'Categoria 2',
      '',
      '',
      '',
      product.images[0] || '',
      product.images[1] || '',
      product.images[2] || '',
      product.images[3] || '',
      product.images[4] || '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    ]

    variants_csv = product.variants.map { export_variant(_1, sku) }

    [product_csv] + variants_csv
  end

  def export_variant(variant, product_sku)
    [
      '',
      'variacao',
      product_sku,
      "#{product_sku}-#{variant.option}",
      'S',
      'N',
      '',
      '',
      '',
      '',
      '',
      'N',
      '',
      'imediata',
      '30 dias',
      'N',
      '',
      variant.price,
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      variant.option,
      '',
    ]
  end
end
