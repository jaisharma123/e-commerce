class OrdersController < ApplicationController

  def create_order
    current_order
    @order = Order.find(session[:order_id])
    @order_item = @order.order_items.create(order_item_params)
  end

  def update_item_quantity
    @order_item = OrderItem.find(params[:order_item][:order_item_id])
    if @order_item.update(item_quantity: params[:order_item][:item_quantity])
      respond_to do |format|
        format.html {redirect_to carts_path, notice: "Cart has been updated successfully."}
      end
    end
  end

  def delete_order_item
    @order_item = OrderItem.find(params[:order_item_id])
    @order_item.destroy
    respond_to do |format|
      format.html {redirect_to carts_path, notice: "Item has been removed from cart successfully."}
    end
  end

  private

    def order_item_params
      params.require(:order_item).permit(:item_name, :item_price, :item_quantity)
    end


end
