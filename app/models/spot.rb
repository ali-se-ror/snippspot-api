class Spot < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :price, presence: true
  validates :location, presence: true
  has_many :reviews
  has_many_attached :spot_images
end
