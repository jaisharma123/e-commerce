class Category < ApplicationRecord
  validates :name,:description, presence: true, uniqueness: true
  has_many :products
end
