require 'rails_helper'

RSpec.describe 'コメント機能', type: :system do
  let(:user) { create(:user) }
  let(:other) { create(:user) }

  context 'ログインしてない時' do
    let(:post) { create(:post, user: other, content: 'すべての不幸は未来への俺にすぎない。') }
    # comentを作成する

    it 'コメントを閲覧できること' do
      visit post_ptah(post)
      # post-comment的なcontainerがあってそこ中身に指定した文言があるかをチェックする
    end
  end

  context 'ログインしている時' do
    before do
      sign_in user
    end

    # - コメントが投稿できること
    it 'コメントを投稿できること' do
      # 投稿の詳細ページへ
      # コメントボタンを押す
      # fill_inで文言を入力
      # コメントするボタンで投稿
      # post.commentsが+1されていることを確認する
      # 文言表示の確認をする
    end

    # - 編集できる
    it 'コメントを編集できること' do
      # 予めコメントを作成する
      # 投稿の詳細ページへ
      # have_contentでコメントの確認
      # fill_inで文言を再度入力
      # コメントするボタンで投稿
      # 文言表示の確認をする
      # 編集前のコメントがないことを確認する
    end

    # - 削除できる
    it 'コメントを削除できること' do
      # 予めコメントを作成する
      # 投稿の詳細ページへ
      # have_contentでコメントの確認
      # 削除ボタンでコメントを削除する
      # 文言表示の確認をする
      # 編集前のコメントがないことを確認する
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
