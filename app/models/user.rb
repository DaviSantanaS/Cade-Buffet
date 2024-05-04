require "cpf_cnpj"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :buffet, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :name, presence: true
  validates :cpf, uniqueness: true, presence: true, cpf: true, if: :regular_user?

  validates_inclusion_of :buffet_owner, in: [true, false]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



  def actual_buffet_owner?(buffet)
    buffet.present? && self.buffet == buffet
  end

  def regular_user?
    !buffet_owner
  end
end
