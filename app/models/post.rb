class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  scope :default_order, -> { order(updated_at: :desc) }
end
