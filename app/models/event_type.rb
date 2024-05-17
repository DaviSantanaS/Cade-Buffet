class EventType < ApplicationRecord
  belongs_to :buffet
  has_many :event_prices, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :photos, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :min_capacity, numericality: { greater_than_or_equal_to: 0 }
  validates :max_capacity, numericality: { greater_than: :min_capacity }
  validates :duration_minutes, numericality: { greater_than: 0 }
  validates :days_of_week, presence: true
  before_save :convert_days_of_week

  before_validation :assign_buffet

  def available_on?(event_date, guest_count)
    return false if guest_count > max_capacity

    existing_order = orders.where(event_date: event_date).exists?
    !existing_order
  end

  def calculate_price(guest_count, event_date)
    event_day = event_date.to_date.wday.to_s
    event_price = event_prices.find_by("days_of_week LIKE ?", "%#{event_day}%")
    base_price = event_price.try(:base_price) || 0
    additional_price_per_person = event_price.try(:additional_price_per_person) || 0

    total_price = base_price + (additional_price_per_person * (guest_count > min_capacity ? guest_count - min_capacity : 0))
    total_price
  end

  private

  def assign_buffet
    self.buffet_id = buffet.id if buffet.present?
  end

  def convert_days_of_week
    if self.days_of_week.is_a?(Array)
      self.days_of_week = self.days_of_week.join(',')
    end
  end
end
