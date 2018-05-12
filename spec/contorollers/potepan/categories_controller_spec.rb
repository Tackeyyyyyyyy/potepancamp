require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe "show Action successfull" do
    let(:taxon) {create(:taxon)}
    before do
      get :show, params: {id: taxon.id}
    end

    it "ステータスコードが200になること" do
      expect(response).to have_http_status 200
    end

  end
end
