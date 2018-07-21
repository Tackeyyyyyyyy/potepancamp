require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe "show Action successfull" do
    let(:target_product) {create(:product)}

    let(:taxonomy_categories) {create(:taxonomy, name: 'Categories')}
    let(:taxonomy_brands) {create(:taxonomy, name: 'Brands')}

    let(:rails_taxon) {create(:taxon, name: 'Rails', taxonomy: taxonomy_brands)}
    let(:ruby_taxon) {create(:taxon, name: 'Ruby', taxonomy: taxonomy_brands)}
    let(:apache_taxon) {create(:taxon, name: 'Apache', taxonomy: taxonomy_brands)}
    let(:mugs_taxon) {create(:taxon, name: 'Mugs', taxonomy: taxonomy_categories)}
    let(:bags_taxon) {create(:taxon, name: 'Bags', taxonomy: taxonomy_categories)}

    let(:mugs_products_by_rails_brand) do
      create_list(:product, 4) do |product|
        product.taxons << rails_taxon
        product.taxons << mugs_taxon
      end
    end

    let(:mug_products_by_apache_brand) do
      create_list(:product, 5) do |product|
        product.taxons << apache_taxon
        product.taxons << mugs_taxon
      end
    end

    let(:bugs_products_by_ruby_brand) do
      create_list(:product, 6) do |product|
        product.taxons << ruby_taxon
        product.taxons << bags_taxon
      end
    end

    before do
      get :show, params: {id: target_product.id}
    end

    it "ステータスコードが200になること" do
      expect(response).to have_http_status 200
    end

    it 'showテンプレートを表示すること' do
      expect(response).to render_template(:show)
    end

    it "@productが期待される値を持つこと" do
      expect(assigns(:product)).to eq target_product
    end

    context 'with a mug (from rails)' do
      let(:target_product) {mugs_products_by_rails_brand.first}
      it "関連する製品には同じカテゴリーの製品が含まれること" do
        related_products = (mugs_products_by_rails_brand - [target_product])
        expect(assigns(:related_products)).to match_array related_products
      end

      it '関連する製品に他のカテゴリーは含まないこと' do
        expect(assigns(:related_products)).not_to include(bugs_products_by_ruby_brand)
      end
    end

    context '関連する製品が3つの場合' do
      let(:target_product) {mugs_products_by_rails_brand.first}
      it '関連する製品の取得件数が3件であること' do
        expect(assigns(:related_products).count).to eq 3
      end
    end

    context '関連する製品が4つの場合' do
      let(:target_product) {mug_products_by_apache_brand.first}
      it '関連する製品の取得件数が4件であること' do
        expect(assigns(:related_products).count).to eq 4
      end
    end

    context '関連する製品が5つの場合' do
      let(:target_product) {bugs_products_by_ruby_brand.first}
      it '関連する製品の取得件数が4件であること' do
        expect(assigns(:related_products).count).to eq 4
      end
    end
  end
end
