class Potepan::CategoriesController < ApplicationController

  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    @products = @taxon.products.includes(master: [:images, :default_price])
  end
end