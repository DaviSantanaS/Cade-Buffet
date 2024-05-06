class EventType < ApplicationRecord
  belongs_to :buffet
  has_many :event_prices, dependent: :destroy
  has_many :orders, dependent: :destroy
  # has_many_attached :photos

  validates :name, presence: true
  validates :description, presence: true
  validates :min_capacity, numericality: { greater_than_or_equal_to: 0 }
  validates :max_capacity, numericality: { greater_than: :min_capacity }
  validates :duration_minutes, numericality: { greater_than: 0 }
  validates :days_of_week, presence: true
  before_save :convert_days_of_week



  before_validation :assign_buffet

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