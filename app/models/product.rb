class Product < ApplicationRecord
  validates :name,:price,:size, presence: true
  belongs_to :category, optional: true
  has_many :images, as: :imageable
  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true
end
