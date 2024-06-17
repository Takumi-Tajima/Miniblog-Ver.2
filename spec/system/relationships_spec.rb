require 'rails_helper'

RSpec.describe 'フォロー機能', type: :system do
  let(:user) { create(:user) }
  let(:other) { create(:user, name: 'jojo') }

  context '他ユーザーをフォローしてない時' do
    before do
      sign_in user
      create(:post, user: other, content: '今日は猫の餌をあげた')
    end

    it 'フォローボタンを押すと、フォローできること' do
      visit root_path
      expect(page).to have_content 'jojo'
      expect(page).to have_content '今日は猫の餌をあげた'
      within '.list-group-item' do
        expect do
          click_on 'フォロー'
          expect(page).to have_content 'フォロー解除'
        end.to change(user.followings, :count).by(1)
        expect(page).not_to have_content('フォロー', exact: true)
      end
    end
  end

  context '他のユーザーをフォローしている時' do
    before do
      sign_in user
      create(:post, user: other, content: '裁くのは俺のスタンドだ')
      user.follow!(other.id)
    end

    it 'フォロー解除ボタンを押すと、フォロー解除できること' do
      visit root_path
      expect(page).to have_content 'jojo'
      expect(page).to have_content '裁くのは俺のスタンドだ'
      within '.list-group-item' do
        expect do
          click_on 'フォロー解除'
          expect(page).to have_content('フォロー')
        end.to change(user.followings, :count).by(-1)
        expect(page).not_to have_content('フォロー解除', exact: true)
      end
    end
  end

  context 'ログインしてない時' do
    let(:post) { create(:post) }

    it 'フォローボタンが表示されていないこと' do
      visit root_path
      expect(page).not_to have_content('フォロー', exact: true)
      expect(page).not_to have_content 'フォロー解除'
    end
  end
end
