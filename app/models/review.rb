class Review < ApplicationRecord
  validates :description, presence: true
  belongs_to :spot, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
