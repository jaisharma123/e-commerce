class AddShippingToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :shipping, :decimal
  end
end
