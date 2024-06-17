require 'rails_helper'

RSpec.describe 'いいね機能', type: :system do
  let(:user) { create(:user, name: 'jojo') }
  let(:other_user) { create(:user, name: 'dio') }

  before do
    sign_in user
    # ポストを作成する
    # factoryでトレットを使用してなんとかする
  end

  it 'いいねできること' do
    visit root_path
    # いいねモデルが+1されてること
    # 表示：いいねカウントが増えてること
  end

  it 'いいねを消せること' do
    # いいねモデルが1されていること
    # 表示：いいねカウントが減っていること
  end

  it 'いいねをしたユーザーを確認できる' do
    # いいねカウンターをクリックする
    # いいねをしたユーザー一覧が出てくる
    # ？どうやっていいねした人の一覧情報を持ってくるの？
  end
end
