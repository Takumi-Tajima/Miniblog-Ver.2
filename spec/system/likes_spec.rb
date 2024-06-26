require 'rails_helper'

RSpec.describe 'いいね機能', type: :system do
  let(:user) { create(:user, name: 'jojo') }
  let(:user2) { create(:user, name: 'dio') }
  let(:user3) { create(:user, name: 'hoge') }
  let!(:post) { create(:post, user: user2) }

  before do
    sign_in user
  end

  it 'いいねできること' do
    visit root_path
    within('.list-group-item') do
      expect(page).to have_content '0'
      expect do
        find('button[test_id="like"]').click
        expect(page).to have_css('button[test_id="not-like"]')
      end.to change(user.likes, :count).by(+1)
      expect(page).to have_content '1'
    end
  end

  it 'いいねを消せること' do
    user.likes.create(post_id: post.id)
    visit root_path
    within('.list-group-item') do
      expect(page).to have_content '1'
      expect do
        find('button[test_id="not-like"]').click
        expect(page).to have_css('button[test_id="like"]')
      end.to change(user.likes, :count).by(-1)
      expect(page).to have_content '0'
    end
  end

  it 'いいねをしたユーザーを確認できる' do
    user2.likes.create(post_id: post.id)
    user3.likes.create(post_id: post.id)
    visit root_path
    within('.list-group-item') do
      click_on '2'
    end
    expect(page).to have_content 'いいねしたユーザー'
    expect(page).to have_content 'dio'
    expect(page).to have_content 'hoge'
  end
end
