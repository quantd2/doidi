class Relationship < ApplicationRecord
  enum status: [:pending, :accepted]

  belongs_to :demander, class_name: "Item"
  belongs_to :granter, class_name: "Item"

  validates :demander_id, presence: true
  validates :granter_id, presence: true
end
