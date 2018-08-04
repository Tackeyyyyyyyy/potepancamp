require 'rails_helper'

RSpec.describe Spree::Product, type: :model do
  describe "related_products test" do
    let(:taxonomy_categories) {create(:taxonomy, name: 'Categories')}
    let(:taxonomy_brands) {create(:taxonomy, name: 'Brands')}

    let(:rails_taxon) {create(:taxon, name: 'Rails', taxonomy: taxonomy_brands)}
    let(:ruby_taxon) {create(:taxon, name: 'Ruby', taxonomy: taxonomy_brands)}
    let(:mugs_taxon) {create(:taxon, name: 'Mugs', taxonomy: taxonomy_categories)}
    let(:bags_taxon) {create(:taxon, name: 'Bags', taxonomy: taxonomy_categories)}

    let(:mugs_products_by_rails_brand) do
      create_list(:product, 4) do |product|
        product.taxons << rails_taxon
        product.taxons << mugs_taxon
      end
    end

    let(:bugs_products_by_ruby_brand) do
      create_list(:product, 20) do |product|
        product.taxons << ruby_taxon
        product.taxons << bags_taxon
      end
    end

    context '関連する製品の取得4件が場合' do
      let(:related_mugs_products) {mugs_products_by_rails_brand.first.related_products}
      it '3件しか取得できないこと' do
        expect(related_mugs_products.count).to eq 3
      end
      it "関連する製品には重複がないこと" do
        expect(related_mugs_products).not_to include mugs_products_by_rails_brand.first
      end

      it "関連しない製品が含まれないこと" do
        expect(related_mugs_products).not_to include bugs_products_by_ruby_brand
      end
    end

    context '関連する製品の取得20件が場合' do
      let(:related_mugs_products) {bugs_products_by_ruby_brand.first.related_products}
      it '10件しか取得できないこと' do
        expect(related_mugs_products.count).to eq 10
      end

      it "関連する製品には重複がないこと" do
        expect(related_mugs_products).not_to include bugs_products_by_ruby_brand.first
      end

      it "関連しない製品が含まれないこと" do
        expect(related_mugs_products).not_to include mugs_products_by_rails_brand
      end
    end

    describe "new_products test" do
      let!(:products_1_day_ago) {create(:product, available_on: 1.day.ago)}
      let!(:products_2_days_ago) {create(:product, available_on: 2.days.ago)}
      let!(:products_3_days_ago) {create(:product, available_on: 3.days.ago)}
      let!(:products_4_days_ago) {create(:product, available_on: 4.days.ago)}

      it "new_productsの取得数が正しいこと" do
        expect(Spree::Product.new_products(3).count).to eq 3
      end

      it "new_productsの並び順が正しいこと" do
        expect(Spree::Product.new_products(3)).to match [products_1_day_ago, products_2_days_ago, products_3_days_ago]
      end

      it "new_productsに古い商品が含まれないこと" do
        expect(Spree::Product.new_products(3)).not_to include products_4_days_ago
      end
    end
  end
end
