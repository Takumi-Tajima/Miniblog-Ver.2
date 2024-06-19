require 'rails_helper'

RSpec.describe 'プロフィール機能', type: :system do
  let(:user) { create(:user, name: 'jojo', about_me: '私の名前は空条承太郎です', blog_url: 'google.com') }

  context 'ログインしている時' do
    it '自分のプロフィールを確認できること' do
      visit root_path
      within('.nav') do
        click_on 'プロフィール'
        expect(page).to have_content 'jojo'
        expect(page).to have_content '私の名前は空条承太郎です'
        # TODO: urlを参照するマッチャを記述する
      end
    end
  end
end
