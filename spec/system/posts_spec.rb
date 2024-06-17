require 'rails_helper'

RSpec.describe 'ポスト機能', type: :system do
  context 'ログインしてない時' do
    let(:user) { create(:user, name: 'hoge') }
    let!(:post) { create(:post, user:, content: '最初のバッターボックスに立ったら、見送りの三振だけはするなよ。', created_at: '2024-01-01 10:00:00') }

    it 'ポストの投稿一覧を閲覧できること' do
      visit root_path
      expect(page).to have_content 'hoge'
      expect(page).to have_content '最初のバッターボックスに立ったら、見送りの三振だけはするなよ。'
      expect(page).to have_content '01月01日(月)'
    end

    it 'ポストの詳細画面を閲覧できること' do
      visit post_path(post)
      expect(page).to have_content 'hoge'
      expect(page).to have_content '最初のバッターボックスに立ったら、見送りの三振だけはするなよ。'
      expect(page).to have_content '01月01日(月)'
    end
  end

  context 'ログインしてる時' do
    let!(:user) { create(:user, name: 'jojo') }

    before do
      sign_in user
    end

    it 'ポストの新規作成ができること' do
      visit root_path
      click_on '新規投稿'
      fill_in '内容', with: 'つぶやきを考えたいけど、なかなか思いつかないものだなぁ'
      expect do
        click_on '登録する'
        expect(page).to have_content '投稿を登録しました'
      end.to change(user.posts, :count).by(1)
      expect(page).to have_content 'つぶやきを考えたいけど、なかなか思いつかないものだなぁ'
      expect(page).to have_content 'jojo'
    end

    it '自分のポストは編集ができること' do
      post = create(:post, user:, content: '君の人生に俺が入ってくる。素晴らしいことだ。出ていってくれたらもっと幸福なのに。')
      visit post_path(post)
      expect(page).to have_content '君の人生に俺が入ってくる。素晴らしいことだ。出ていってくれたらもっと幸福なのに。'
      expect(page).to have_content 'jojo'
      click_on '編集'
      fill_in '内容', with: '私がおにであるとき、私は最もおにではない。'
      click_on '更新'
      expect(page).to have_content '投稿を編集しました'
      expect(page).not_to have_content '君の人生に俺が入ってくる。素晴らしいことだ。出ていってくれたらもっと幸福なのに。'
      expect(page).to have_content '私がおにであるとき、私は最もおにではない。'
    end

    it '自分のポストは削除できること' do
      post = create(:post, user:, content: 'wryyyと呟きたい。俺')
      visit root_path
      click_on 'wryyyと呟きたい。俺'
      expect(page).to have_current_path post_path(post)
      click_on '削除'
      expect(page).to have_content '投稿を削除しました'
      expect(page).not_to have_content 'wryyyと呟きたい。俺'
    end

    context '他人の投稿の時' do
      let(:other_user) { create(:user, name: 'dio') }

      before do
        create(:post, user: other_user, content: '今まで食べたパンの枚数を覚えているのか？')
      end

      it 'ポストの編集ができないこと' do
        visit root_path
        click_on '今まで食べたパンの枚数を覚えているのか？'
        expect(page).not_to have_content '編集'
      end

      it 'ポストの削除ができないこと' do
        visit root_path
        click_on '今まで食べたパンの枚数を覚えているのか？'
        expect(page).not_to have_content '削除'
      end
    end

    context 'フォロー中のユーザーの投稿ボタンを押した時' do
      let(:dio) { create(:user, name: 'dio') }
      let(:iggy) { create(:user, name: 'iggy') }

      before do
        create(:post, user: dio, content: '最後に勝つのはこのdioだ')
        create(:post, user: iggy, content: '見殺しにはできねぇぜ')
        user.follow!(dio.id)
        visit root_path
      end

      it '自分のフォローしているユーザーの投稿のみを閲覧できる' do
        click_on 'フォロー中のユーザーの投稿'
        expect(page).to have_content 'dio'
        expect(page).to have_selector('.list-group-item', text: '最後に勝つのはこのdioだ', count: 1)
        expect(page).not_to have_content 'iggy'
        expect(page).not_to have_selector('.list-group-item', text: '見殺しにはできねぇぜ')
      end
    end
  end
end
