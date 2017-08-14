class Category < ApplicationRecord
  include Common

  has_many :categorizations
  has_many :items, through: :categorizations

  validates :name, length: { minimum: 1, maximum: 30 },
                  presence: true, uniqueness: true

  has_ancestry
end
