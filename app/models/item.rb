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
            foreign_key: "demander_id",
            dependent: :destroy,
            before_add: :check_demanding_limit
  has_many :granter_items, through: :relationships, source: :granter

  has_many :reverse_relationships,
            foreign_key: "granter_id",
            class_name: "Relationship",
            dependent: :destroy,
            before_add: :check_granting_limit
  has_many :demander_items, through: :reverse_relationships, source: :demander

  validates :name, length: { minimum: 1, maximum: 50 }, presence: true
  validates :description, length: { minimum: 0, maximum: 1000 }

  paginates_per 10

  def demanding?(other_item)
    relationships.find_by_granter_id(other_item.id)
  end

  def demand!(other_item)
    relationships.create!(granter_id: other_item.id)
  end

  def accept!(other_item)
    relationships.create!(granter_id: other_item.id, status: 1)
    reverse_relationships.find_by_granter_id(self.id).update_attribute(:status, 1)
  end

  def withhold!
    relationships.find_by_demander_id(self.id).destroy
  end

  def deny!(other_item)
    reverse_relationships.find_by_demander_id(other_item.id).destroy
  end

  MESSAGE = "Món đồ của bạn đã được đề nghị đổi!"

  def check_demanding_limit relationship
    if self.relationships.present?
      errors.add(:relationships, message: MESSAGE)
      raise Exception.new MESSAGE
    end
  end

  def check_granting_limit reverse_relationship
    if self.reverse_relationships.present?
      errors.add(:reverse_relationships, message: MESSAGE)
      raise Exception.new MESSAGE
    end
  end
end
