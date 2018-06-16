class Potepan::ProductsController < ApplicationController
  RELATED_PRODUCTS_DISPLAY_LIMIT = 4

  def show
    @product = Spree::Product.find(params[:id])
    @related_products = Spree::Product.related_products(@product).order("RAND()").limit(RELATED_PRODUCTS_DISPLAY_LIMIT)
  end
  
end