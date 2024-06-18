class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :user_id, uniquness: { scope: post_id }
end
