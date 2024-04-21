class EventType < ApplicationRecord
  belongs_to :buffet
  has_many :event_prices, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :min_capacity, numericality: { greater_than_or_equal_to: 0 }
  validates :max_capacity, numericality: { greater_than: :min_capacity }
  validates :duration_minutes, numericality: { greater_than: 0 }

  before_validation :assign_buffet

  private

  def assign_buffet
    self.buffet_id = buffet.id if buffet.present?
  end
end