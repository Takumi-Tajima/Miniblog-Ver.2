class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy, inverse_of: 'follower'
  has_many :followings, through: :active_relationships, source: :followed
  validates :name, presence: true, format: { with: /\A\w+\z/ }, length: { maximum: 20 }

  def follow!(user_id)
    active_relationships.create!(followed_id: user_id)
  end

  def unfollow!(user_id)
    active_relationships.find_by!(followed_id: user_id).destroy!
  end

  def following?(user)
    followings.exists?(user.id)
  end
end
