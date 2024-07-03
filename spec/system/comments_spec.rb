require 'rails_helper'

RSpec.describe 'コメント機能', type: :system do
  let(:user) { create(:user) }
  let(:other) { create(:user) }
  let(:post) { create(:post, user: other, content: 'すべての不幸は未来への俺にすぎない。') }

  context 'ログインしてない時' do
    before do
      create(:comment, user:, post:, content: 'コメント失礼します')
    end

    it 'コメントを閲覧できること' do
      visit post_path(post)
      within('.comment') do
        expect(page).to have_content 'コメント失礼します'
      end
    end
  end

  context 'ログインしている時' do
    before do
      sign_in user
    end

    it 'コメントを投稿できること' do
      visit post_path(post)
      click_on 'コメントする'
      fill_in 'コメント', with: 'Railsについてコメントをします'
      expect do
        click_on '登録する'
        expect(page).to have_content 'コメントを登録しました。'
      end.to change(post.comments, :count).by(1)
      expect(page).to have_content 'Railsについてコメントをします'
    end

    it 'コメントを編集できること' do
      create(:comment, user:, post:, content: '何をやっているんだお前は')
      visit post_path(post)
      expect(page).to have_content '何をやっているんだお前は'
      within('.list-group-item') do
        click_on '編集'
      end
      fill_in 'コメント', with: 'こっちのセリフですよ'
      click_on '更新する'
      expect(page).to have_content 'コメントを編集しました。'
      expect(page).not_to have_content '何をやっているんだお前は'
      expect(page).to have_content 'こっちのセリフですよ'
    end

    it 'コメントを削除できること' do
      create(:comment, user:, post:, content: 'ジムに行きたいですが、テストも書き終えたいです')
      visit post_path(post)
      expect(page).to have_content 'ジムに行きたいですが、テストも書き終えたいです'
      expect do
        click_button '削除'
        expect(page).to have_content 'コメントを削除しました。'
      end.to change(post.comments, :count).by(-1)
      expect(page).not_to have_content 'ジムに行きたいですが、テストも書き終えたいです'
    end

    it '他人の投稿は編集できない' do
      create(:comment, user: other, post:, content: 'スタンドのパワーを全開だ')
      visit post_path(post)
      expect(page).to have_content 'スタンドのパワーを全開だ'
      expect(page).not_to have_selector '.btn-outline-success', text: '編集'
    end

    it '他人の投稿は削除できない' do
      create(:comment, user: other, post:, content: 'お前は俺を怒らせた')
      visit post_path(post)
      expect(page).to have_content 'お前は俺を怒らせた'
      expect(page).not_to have_selector '.btn-outline-danger', text: '削除'
    end
  end
end
