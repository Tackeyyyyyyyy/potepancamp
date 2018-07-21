Spree::Product.class_eval do
  RELATED_PRODUCT_LIMIT = 10

  scope :related, -> (product) {
    joins(:taxons).where(spree_taxons: {id: product.taxons.ids}).where.not(id: product.id).distinct
  }
  scope :include_price_and_image, -> {
    includes(master: [:default_price, :images])
  }

  # @return ActiveRecord::Relation
  def related_products
    Spree::Product.include_price_and_image.related(self).limit(RELATED_PRODUCT_LIMIT)
  end
end
