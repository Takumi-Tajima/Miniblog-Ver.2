require 'rails_helper'

RSpec.describe 'プロフィール機能', type: :system do
  let(:user) { create(:user, name: 'jojo', about_me: '私の名前は空条承太郎です', blog_url: 'google.com') }

  before do
    sign_in user
  end

  context 'ログインしている時' do
    it '自分のプロフィールを確認できること' do
      visit root_path
      within('.nav') do
        click_on 'プロフィール'
      end
      expect(page).to have_content 'jojo'
      expect(page).to have_content '私の名前は空条承太郎です'
      expect(page).to have_content 'google.com'
    end
  end
end
