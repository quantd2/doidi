class Comment < ApplicationRecord
  include Common

  belongs_to :user
  belongs_to :commentable, polymorphic: true, touch: true
  has_many :comments, as: :commentable, dependent: :destroy

  alias_attribute :author, :user
  validates :body, presence: true

  paginates_per 10
end
