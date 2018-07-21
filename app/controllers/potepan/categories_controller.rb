class Potepan::CategoriesController < ApplicationController

  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    @products = @taxon.products.include_price_and_image
  end
end