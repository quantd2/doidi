class Comment < ApplicationRecord
  include Common

  belongs_to :user
  belongs_to :item

  alias_attribute :author, :user
  validates :body, presence: true

  has_ancestry
  paginates_per 10
end
