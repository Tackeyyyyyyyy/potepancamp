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
      create_list(:product, 6) do |product|
        product.taxons << ruby_taxon
        product.taxons << bags_taxon
      end
    end

    context '関連する製品の取得0件が場合' do
      let(:related_mugs_products) {mugs_products_by_rails_brand.first.related_products(0)}
      it '0件であること' do
        expect(related_mugs_products.count).to eq 0
      end
    end

    context '関連する製品の取得3件が場合' do
      let(:related_mugs_products) {mugs_products_by_rails_brand.first.related_products(3)}
      it '3件であること' do
        expect(related_mugs_products.count).to eq 3
      end
      it "関連する製品には重複がないこと" do
        expect(related_mugs_products).not_to include mugs_products_by_rails_brand.first
      end

      it "関連しない製品が含まれないこと" do
        expect(related_mugs_products).not_to include bugs_products_by_ruby_brand
      end
    end

    context '関連する製品の取得10件が場合' do
      let(:related_mugs_products) {mugs_products_by_rails_brand.first.related_products(10)}
      it '3件であること' do
        expect(related_mugs_products.count).to eq 3
      end
      it "関連する製品には重複がないこと" do
        expect(related_mugs_products).not_to include mugs_products_by_rails_brand.first
      end

      it "関連しない製品が含まれないこと" do
        expect(related_mugs_products).not_to include bugs_products_by_ruby_brand
      end
    end
  end
end
