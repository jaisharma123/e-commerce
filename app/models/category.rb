class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name,:description, presence: true, uniqueness: true
  has_many :products
end
