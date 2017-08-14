class Item < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :categorizations
  has_many :categories, through: :categorizations

  mount_uploader :image, ImageUploader

  default_scope {order(:created_at => :desc)}

  has_many :relationships,
            foreign_key: "follower_id",
            dependent: :destroy,
            before_add: :check_following_limit
  has_many :followed_items, through: :relationships, source: :followed

  has_many :reverse_relationships,
            foreign_key: "followed_id",
            class_name: "Relationship",
            dependent: :destroy,
            before_add: :check_followed_limit
  has_many :followers_items, through: :reverse_relationships, source: :follower

  validates :name, length: { minimum: 1, maximum: 50 }, presence: true
  validates :description, length: { minimum: 0, maximum: 300 }

  def following?(other_item)
    relationships.find_by_followed_id(other_item.id)
  end

  def follow!(other_item)
    relationships.create!(followed_id: other_item.id)
  end

  def unfollow!(other_item)
    relationships.find_by_followed_id(other_item.id).destroy
  end

  def check_following_limit relationship
    if self.relationships.count > 2
      errors.add(:relationships, message: 'you can just follow maximum 3 items')
      raise Exception.new 'you can just follow maximum 3 items'
    end
  end

  def check_followed_limit reverse_relationship
    if self.reverse_relationships.count > 2
      errors.add(:reverse_relationships, message: 'this item has been already followed by mazimum 3 items')
      raise Exception.new 'this item has been already followed by mazimum 3 items'
    end
  end
end
