class Product < ApplicationRecord
 extend FriendlyId
 friendly_id :name, use: :slugged
 default_scope { where(active: true) }
 scope :similar_products, ->(product) { where("id != ? and category_id = ?", product.id, product.category_id) }
 validates :name,:price,:size, presence: true
 belongs_to :category
 has_many :images, as: :imageable
 accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true

end
