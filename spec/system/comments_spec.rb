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

    # - コメントが投稿できること
    it 'コメントを投稿できること' do
      # 投稿の詳細ページへ
      visit post_path(post)
      # コメントボタンを押す
      click_on 'コメントする'
      fill_in 'コメント', with: 'Railsについてコメントをします'
      expect do
        click_on '登録する'
        expect(page).to have_content 'コメントを登録しました。'
      end.to change(post.comments, :count).by(1)
      expect(page).to have_content 'Railsについてコメントをします'
    end

    # - 編集できる
    it 'コメントを編集できること' do
      create(:comment, user:, post:, content: '何をやっているんだお前は')
      # 投稿の詳細ページへ
      visit post_path(post)
      # have_contentでコメントの確認
      expect(page).to have_content '何をやっているんだお前は'
      # fill_inで文言を再度入力
      within('.list-group-item') do
        click_on '編集'
      end
      fill_in 'コメント', with: 'こっちのセリフですよ'
      click_on '更新する'
      expect(page).to have_content 'コメントを編集しました。'
      # 文言表示の確認をする
      expect(page).not_to have_content '何をやっているんだお前は'
      expect(page).to have_content 'こっちのセリフですよ'
      # 編集前のコメントがないことを確認する
    end

    # - 削除できる
    it 'コメントを削除できること' do
      # 予めコメントを作成する
      create(:comment, user:, post:, content: 'ジムに行きたいですが、テストも書き終えたいです')
      visit post_path(post)
      expect(page).to have_content 'ジムに行きたいですが、テストも書き終えたいです'
      expect do
        click_button '削除'
        expect(page).to have_content 'コメントを削除しました。'
      end.to change(post.comments, :count).by(-1)
      expect(page).not_to have_content 'ジムに行きたいですが、テストも書き終えたいです'
    end

    # - 他人のコメントは編集できない
    it '他人の投稿は編集できない' do
      # 予め、コメントを別ユーザーで作成する
      # 投稿詳細ページへ
      # 編集ボタンがないことを確認する
    end

    # - 他人のコメントは編集できない
    it '他人の投稿は削除できない' do
      # 予め、コメントを別ユーザーで作成する
      # 投稿詳細ページへ
      # 削除ボタンがないことを確認する
    end
  end
end
