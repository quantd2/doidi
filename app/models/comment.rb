class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item

  alias_attribute :author, :user
  validates :body, presence: true

  default_scope { order(created_at: :desc) }

  has_ancestry
  paginates_per 10
end
