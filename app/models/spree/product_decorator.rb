Spree::Product.class_eval do
  scope :related, -> (product) {
    joins(:taxons).where(spree_taxons: {id: product.taxons.ids}).where.not(id: product.id).distinct
  }
  scope :include_price_and_image, -> {
    includes(master: [:default_price, :images])
  }

  # @param [int] size
  # @return ActiveRecord::Relation
  def related_products(size)
    limit = size * 2
    Spree::Product.include_price_and_image.related(self).limit(limit).sample(size)
  end
end
