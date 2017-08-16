class Item < ApplicationRecord
  include Common

  belongs_to :user
  has_many :comments
  has_many :categorizations
  has_many :categories, through: :categorizations
  accepts_nested_attributes_for :categorizations
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
  validates :description, length: { minimum: 0, maximum: 1000 }

  paginates_per 10

  def following?(other_item)
    relationships.find_by_followed_id(other_item.id)
  end

  def follow!(other_item)
    relationships.create!(followed_id: other_item.id)
    #reverse_relationships.create!(follower_id: other_item.id)
  end

  def unfollow!(other_item)
    relationships.find_by_followed_id(other_item.id).destroy
    #reverse_relationships.find_by_follower_id(other_item.id).destroy
  end

  MESSAGE = "Món đồ của bạn đã được đề nghị đổi!"

  def check_following_limit relationship
    if self.relationships.present?
      errors.add(:relationships, message: MESSAGE)
      raise Exception.new MESSAGE
    end
  end

  def check_followed_limit reverse_relationship
    if self.reverse_relationships.present?
      errors.add(:reverse_relationships, message: MESSAGE)
      raise Exception.new MESSAGE
    end
  end
end
