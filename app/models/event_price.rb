class EventPrice < ApplicationRecord
  belongs_to :event_type
  belongs_to :buffet

  validates :base_price, numericality: { greater_than_or_equal_to: 0 }
  validates :additional_price_per_person, numericality: { greater_than_or_equal_to: 0 }
  validates :extra_hour_price, numericality: { greater_than_or_equal_to: 0 }
end
