class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :buffet, dependent: :destroy
  validates :name, presence: true
  validates_inclusion_of :buffet_owner, in: [true, false]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
