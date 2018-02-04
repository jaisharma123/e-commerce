class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name,:description, presence: true, uniqueness: true
  has_and_belongs_to_many :products
end
