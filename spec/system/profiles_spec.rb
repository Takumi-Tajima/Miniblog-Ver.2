require 'rails_helper'

RSpec.describe 'プロフィール機能', type: :system do
  let(:user) { create(:user, name: 'jojo', about_me: '私の名前は空条承太郎です', blog_url: 'google.com') }

  before do
    sign_in user
  end

  context '自分のプロフィールの時' do
    it '自分のプロフィールを確認できること' do
      visit root_path
      within('.nav') do
        click_on 'プロフィール'
      end
      expect(page).to have_content 'jojo'
      expect(page).to have_content '私の名前は空条承太郎です'
      expect(page).to have_content 'google.com'
    end

    it '自分のプロフィールを編集できること' do
      visit profile_path
      click_on '編集'
      fill_in '自己紹介',	with: '自己紹介をします'
      fill_in 'user_blog_url', with: 'taji.blog'
      click_on '更新する'
      expect(page).to have_content '自己紹介をします'
      expect(page).to have_content 'taji.blog'
      expect(page).not_to have_content '私の名前は空条承太郎です'
      expect(page).not_to have_content 'google.com'
    end
  end

  context '他人のプロフィールの時' do
    let(:other) { create(:user, name: 'dio', about_me: '私の名前はdioです', blog_url: 'taji.blog') }

    before do
      create(:post, user: other, content: 'wryyyyyyy')
    end

    it '他人のプロフィールを確認できること' do
      visit root_path
      within '.list-group-item' do
        expect(page).to have_content 'wryyyyyyy'
        click_on 'dio'
      end
      expect(page).to have_content 'dio'
      expect(page).to have_content '私の名前はdioです'
      expect(page).to have_content 'taji.blog'
    end
  end
end
