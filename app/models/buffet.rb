class Buffet < ApplicationRecord
  belongs_to :user
  has_many :event_types, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :name, :company_name, :cnpj, :phone, :contact_email,
            :address, :district, :state, :city, :zip_code, :user_id, presence: true

  validate :valid_cnpj
  validate :valid_phone_format
  validates :state, length: { maximum: 2 }
  validates :city, length: { maximum: 255 }
  validates :zip_code, length: { maximum: 8 }

  private

  def valid_cnpj
    return if cnpj.blank?

    errors.add(:cnpj, I18n.t('activerecord.errors.messages.cnpj')) unless CNPJ.valid?(cnpj)
  end

  def valid_phone_format
    return if phone.blank?

    regex = /\A(\(\d{2}\)\s)?\d{9}\z|\A\d{11}\z|\A\d{2}-\d{5}-\d{4}\z/
    unless phone.match?(regex)
      errors.add(:phone, I18n.t('activerecord.errors.messages.phone'))
    end
  end
end
