class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  scope :default_order, -> { order(updated_at: :desc) }

  validates :content, presence: true
end
