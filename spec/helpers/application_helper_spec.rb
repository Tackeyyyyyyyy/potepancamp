require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'full_titleのテスト' do

    context "ページタイトルが空文字列の場合" do
      it "ベースタイトルだけ表示されること" do
        expect(helper.full_title('')).to eq('BIGBAG Store')
      end
    end

    context "ページタイトルが空文字でない場合" do
      it "ページタイトルとベースタイトルが表示されること" do
        expect(helper.full_title('PageTitle')).to eq('PageTitle - BIGBAG Store')
      end
    end

  end
end