require 'rails_helper'

RSpec.describe Potepan::HomeController, type: :controller do
  describe "index Action successfull" do
    before do
      get :index
    end

    it "ステータスコードが200になること" do
      expect(response).to have_http_status 200
    end

    it 'indexテンプレートを表示すること' do
      expect(response).to render_template(:index)
    end
  end
end
