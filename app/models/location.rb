class Location < ApplicationRecord
  has_many :items

  validates :city, length: { minimum: 1, maximum: 30 },
                    presence: true, uniqueness: true
end
