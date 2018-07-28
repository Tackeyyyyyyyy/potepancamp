class Potepan::HomeController < ApplicationController
  AVAILABLE_PRODUCTS_COUNT = 4

  def index
    @featured_products = Spree::Product.new_products(AVAILABLE_PRODUCTS_COUNT)
  end
end
