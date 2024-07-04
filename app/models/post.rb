class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, 150]
    attachable.variant :display, resize_to_limit: [1024, 500]
  end
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  validates :content, presence: true
  scope :default_order, -> { order(updated_at: :desc) }
end
