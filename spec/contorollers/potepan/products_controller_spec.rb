require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe "show Action successfull" do
    let(:product) {create(:product)}
    let(:taxonomy_categories) {create(:taxonomy, name: 'Categories')}
    let(:taxonomy_brands) {create(:taxonomy, name: 'Brands')}
    let(:rails_taxon) {create(:taxon, name: 'Rails', taxonomy: taxonomy_brands)}
    let(:ruby_taxon) {create(:taxon, name: 'Ruby', taxonomy: taxonomy_brands)}
    let(:mugs_taxon) {create(:taxon, name: 'Mugs', taxonomy: taxonomy_categories)}
    let(:bags_taxon) {create(:taxon, name: 'Bags', taxonomy: taxonomy_categories)}
    let(:related_products_count) { 4 }

    let(:mugs_products) do
      create_list(:product, 4) do |product|
        product.taxons << rails_taxon
        product.taxons << mugs_taxon
      end
    end

    let(:bugs_products) do
      create_list(:product, 6) do |product|
        product.taxons << ruby_taxon
        product.taxons << bags_taxon
      end
    end

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

    it "関連する製品には同じカテゴリーの製品が含まれること" do
      mugs_product = mugs_products.first
      related_products = (mugs_products - [mugs_product])
      get :show, params: {id: mugs_product.id}
      expect(assigns(:related_products)).to match_array related_products
    end

    it '関連する製品に他のカテゴリーは含まないこと' do
      bugs_product = bugs_products.first
      get :show, params: {id: bugs_product.id}
      expect(assigns(:related_products)).not_to include(mugs_products)
    end

    it '関連する製品の取得件数が [RELATED_PRODUCTS_DISPLAY_LIMIT] を超えないこと' do
      bugs_product = bugs_products.first
      get :show, params: {id: bugs_product.id}
      expect(assigns(:related_products).count).to be <= related_products_count
    end
  end
end
