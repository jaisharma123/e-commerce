class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @q = Product.ransack(params[:q])
     @products = @q.result(distinct: true)
  end

  def show
  #    @product = Product.friendly.find(params[:id])
  end

  private

    def set_product
      @product = Product.friendly.find(params[:id])
    end

end