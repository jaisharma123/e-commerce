class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  def total
    total = self.order_items.map {|oi| oi.item_price * oi.item_quantity }.sum
  end
end
