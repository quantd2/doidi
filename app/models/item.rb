class Item < ApplicationRecord
  include Filterable

  belongs_to :user
  validates :user, presence: true
  belongs_to :location
  validates :location, presence: true
  belongs_to :category
  validates :category, presence: true
  has_many :comments
  mount_uploader :image, ImageUploader
  process_in_background :image

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

  def is_accepted?
    if relationships.present?
      return relationships.first.status == "accepted"
    else
      false
    end
  end

  def demanded?
    relationships.present?
  end

  def got_demanded?
    reverse_relationships.present?
  end

  def demander
    demander_items.first.user
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

  scope :location,   -> (location_id) { where(location_id: (get_children_id Location, location_id)) }
  scope :category,   -> (category_id) { where(category_id: (get_children_id Category, category_id)) }
  scope :demandable, -> (demandable)  { where('items.id NOT IN (SELECT granter_id FROM relationships)
                                      AND items.id NOT IN (SELECT demander_id FROM relationships)') if demandable.present? }

  def self.get_children_id class_name, id
    loc = class_name.find_by_id(id)
    return(loc.children.present? ? loc.subtree_ids : id)
  end

  include PgSearch
  pg_search_scope :search, against: [:name, :description],
    ignoring: :accents

  def self.text_search(query)
    if query.present?
      search(query)
    else
      self.all
    end
  end
end
