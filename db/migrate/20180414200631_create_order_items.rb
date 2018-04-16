class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.string :item_name
      t.integer :item_quantity
      t.integer :item_price
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
