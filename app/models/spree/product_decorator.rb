Spree::Product.class_eval do
  scope :related_products, -> (product) {
    joins(:taxons).where(spree_taxons: {id: product.taxons.ids}).where.not(id: product.id).distinct
  }
  scope :include_price_and_image, -> {
    includes(master: [:default_price, :images])
  }

  def related_products(product)
    Spree::Product.include_price_and_image.related_products(self)
  end
end
