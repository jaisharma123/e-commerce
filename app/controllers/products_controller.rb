class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  layout 'site'

  def index
    category = Category.where('categories in (?)', params[:categories]);
    # product = Product.where ('products in (?)', params[:products]);
    respond_to do |format|
      format.js
      format.html
    end
    @categories = Category.all
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).page(params[:page]).per(9)
  end

  def show
    @product = Product.friendly.find(params[:id])
  end

  def filtered_products
      # @category = Category.find(params[:category_id])
      # @products = @category.products

      if params[:category_id].present? && params[:size].present?
        @products = Product.where(category_id: params[:category_id], size: params[:size] )
      elsif params[:category_id].present?
        @products =  Product.where(category_id: params[:category_id])
      elsif params[:size].present?
        @products = Product.where(size: params[:size] )
      else
       @products = Product.all
      end
    end




    private

    def set_product
      @product = Product.friendly.find(params[:id])
    end

  end