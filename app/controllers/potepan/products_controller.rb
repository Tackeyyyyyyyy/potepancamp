class Potepan::ProductsController < ApplicationController
  RELATED_PRODUCTS_DISPLAY_LIMIT = 4

  def show
    @product = Spree::Product.find(params[:id])
    @related_products = Spree::Product.related_products(@product).sample(RELATED_PRODUCTS_DISPLAY_LIMIT)
  end
  
end