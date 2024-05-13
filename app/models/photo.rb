class Photo < ApplicationRecord
  belongs_to :event_type

  has_one_attached :image


  validates :author, presence: true
  validates :published_at, presence: true
end