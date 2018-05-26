class Potepan::RootController < ApplicationController
  AVAILABLE_PRODUCTS_COUNT = 4
  def index
    @featured_products =  Spree::Product.order(available_on: :desc).limit(AVAILABLE_PRODUCTS_COUNT)
  end
end
