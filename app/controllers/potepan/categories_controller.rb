class Potepan::CategoriesController < ApplicationController

  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    @products = Spree::Product.in_taxon(@taxon)
  end
end