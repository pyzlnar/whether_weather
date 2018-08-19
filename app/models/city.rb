class City < ApplicationRecord
  validates :name,
            presence: true

  validates :open_weather_id,
            presence:   true,
            uniqueness: true
end
