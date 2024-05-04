class Order < ApplicationRecord
  belongs_to :user
  belongs_to :buffet
  belongs_to :event_type

  validates :event_date, :guest_count, :details, presence: true
  validates :code, uniqueness: true, length: { is: 8 }

  before_validation :generate_code, on: :create
  before_validation :set_default_status, on: :create

  enum status: { pending: 'pending', confirmed: 'confirmed', cancelled: 'cancelled' }

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def set_default_status
    self.status ||= :pending
  end
end
