class Potepan::ProductsController < ApplicationController
  RELATED_PRODUCTS_DISPLAY_LIMIT = 4

  def show
    @product = Spree::Product.find(params[:id])
    @related_products = @product.related_products(RELATED_PRODUCTS_DISPLAY_LIMIT)
  end
  
end