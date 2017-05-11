class Station < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude

  validates :name, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
  validates :available_bikes, presence: true, numericality: {only_integer: true}
end
