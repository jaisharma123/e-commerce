class OrderItem < ApplicationRecord
  belongs_to :order, optional: true

  def subtotal
    self.item_price * self.item_quantity
  end

end
