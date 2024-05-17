class EventPrice < ApplicationRecord
  belongs_to :event_type
  belongs_to :buffet

  validates :base_price, numericality: { greater_than_or_equal_to: 0 }
  validates :additional_price_per_person, numericality: { greater_than_or_equal_to: 0 }
  validates :extra_hour_price, numericality: { greater_than_or_equal_to: 0 }
  validates :days_of_week, presence: true

  validate :unique_days_of_week_for_event_type

  private

  def unique_days_of_week_for_event_type
    return if days_of_week.blank?

    existing_days = EventPrice.where(event_type_id: event_type_id, buffet_id: buffet_id)
                              .where.not(id: id)
                              .pluck(:days_of_week)
                              .map { |days| JSON.parse(days) }.flatten.uniq

    new_days = JSON.parse(days_of_week)

    unless (existing_days & new_days).empty?
      errors.add(:days_of_week, I18n.t('activerecord.errors.messages.unique_days_of_week_for_event_type'))
    end
  end
end
