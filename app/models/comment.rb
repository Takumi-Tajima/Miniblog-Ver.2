class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, presence: true
  scope :comments_order, -> { order(:created_at) }
end
