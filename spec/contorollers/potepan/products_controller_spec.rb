require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe "show Action successfull" do
    let(:product) {create(:product)}
    before do
      get :show, params: {id: product.id}
    end

    it "ステータスコードが200になること" do
      expect(response).to have_http_status 200
    end

    it 'showテンプレートを表示すること' do
      expect(response).to render_template(:show)
    end

    it "@productが期待される値を持つこと" do
      expect(assigns(:product)).to eq product
    end
  end
end
