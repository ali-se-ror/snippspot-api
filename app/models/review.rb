class Review < ApplicationRecord
  validates :description, presence: true
  belongs_to :spot, dependent: :destroy
end
