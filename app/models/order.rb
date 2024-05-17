class Order < ApplicationRecord
  belongs_to :user
  belongs_to :buffet
  belongs_to :event_type

  validates :event_date, :guest_count, :details, presence: true
  validates :code, uniqueness: true, length: { is: 8 }
  validates :price_validity, presence: true, if: -> { status == 'confirmed' }

  validate :guest_count_within_capacity, on: :create
  validate :event_date_cannot_be_in_the_past

  before_validation :generate_code, on: :create
  before_validation :set_default_status, on: :create
  before_save :set_default_price_validity, if: -> { price_validity.blank? }

  enum status: { pending: 'pending', confirmed: 'confirmed', cancelled: 'cancelled' }

  def calculate_price
    event_price = find_event_price_for_day(event_date.wday)

    if event_price
      base_price = calculate_based_on_capacity(event_price)
      final_price = base_price + (price_adjustment.to_d)
      update(price: final_price)
    else
      errors.add(:base, "No pricing available for the selected day.")
    end
  end

  def confirm_by_client!
    return false if Date.today > self.price_validity || self.confirmed_by_client

    update(confirmed_by_client: true)
  end

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def set_default_status
    self.status ||= :pending
  end

  def guest_count_within_capacity
    if event_type && guest_count && event_type.max_capacity && guest_count > event_type.max_capacity
      errors.add(:guest_count, I18n.t('activerecord.errors.messages.guest_count_within_capacity', max_capacity: event_type.max_capacity))
    end
  end

  def event_date_cannot_be_in_the_past
    errors.add(:event_date, I18n.t('activerecord.errors.messages.event_date_cannot_be_in_the_past')) if event_date.present? && event_date < Date.current
  end

  def find_event_price_for_day(day_of_week)
    event_type.event_prices.find do |price|
      days = JSON.parse(price.days_of_week)
      days.include?(day_of_week.to_s)
    end
  end

  def calculate_based_on_capacity(event_price)
    if guest_count < event_type.min_capacity
      event_price.base_price
    else
      event_price.base_price + (guest_count - event_type.min_capacity) * event_price.additional_price_per_person
    end
  end

  def set_default_price_validity
    self.price_validity = Date.today + 2.days
  end
end
