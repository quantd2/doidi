class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "Item"
  belongs_to :followed, class_name: "Item"

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
