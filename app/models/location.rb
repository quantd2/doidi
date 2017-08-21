class Location < ApplicationRecord
  include Tree

  has_many :items

  validates :name, length: { minimum: 1, maximum: 30 },
                    presence: true
end
