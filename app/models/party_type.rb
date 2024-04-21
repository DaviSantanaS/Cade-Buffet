class PartyType < ApplicationRecord
  has_and_belongs_to_many :buffets

  validates_presence_of :name
  validates_length_of :name, maximum: 255

end
