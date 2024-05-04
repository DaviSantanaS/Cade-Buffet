class Buffet < ApplicationRecord
  belongs_to :user
  has_many :event_types, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates_presence_of :name, :company_name, :cnpj, :phone, :contact_email,
                        :address, :district, :state, :city, :zip_code, :user_id
  validates_format_of :cnpj, with: /\d{14}/, message: 'CNPJ must be in the format 12345678901234'
  validates_format_of :phone, with: /\d{2}-\d{5}-\d{4}/, message: 'Phone number must be in the format XX-XXXX-XXXX'
  validates_length_of :state, maximum: 2
  validates_length_of :city, maximum: 255
  validates_length_of :zip_code, maximum: 8

end