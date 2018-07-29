require 'rails_helper'

RSpec.describe Potepan::HomeController, type: :controller do
  describe "index Action successfull" do
    let(:available_products_count) {4}
    let(:new_products) {create_list(:product, available_products_count, name: 'new_product', available_on: 1.hour.ago)}
    let(:old_products) {create_list(:product, 3, name: 'old_product', available_on: 2.hours.ago)}

    before do
      get :index
    end

    it "ステータスコードが200になること" do
      expect(response).to have_http_status 200
    end

    it 'indexテンプレートを表示すること' do
      expect(response).to render_template(:index)
    end

    it "@featured_productsに新着商品が含まれていること" do
      expect(assigns(:featured_products)).to match_array new_products
    end

    it "@featured_productsがavailable_products_countを超えないこと" do
      expect(assigns(:featured_products).count).to be <= available_products_count
    end

    it "古い商品は表示されないこと" do
      expect(assigns(:featured_products)).not_to include old_products
    end
  end
end
