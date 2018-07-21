class Potepan::HomeController < ApplicationController
  AVAILABLE_PRODUCTS_COUNT = 4

  def index
    @featured_products = Spree::Product.load_new_products(AVAILABLE_PRODUCTS_COUNT)
  end
end
