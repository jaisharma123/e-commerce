class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  layout 'site'

  def index
    category = Category.where('categories in (?)', params[:categories]);
    respond_to do |format|
      format.js
      format.html
    end
    @categories = Category.all
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end

  def show
    @product = Product.friendly.find(params[:id])
  end

  def filtered_products
      # @category = Category.find(params[:category_id])
      # @products = @category.products


      if params[:category_id].present?
        @categories = Category.where('id IN (?)', params[:category_id])
      else
        @categories = Category.all
      end
      @products = @categories.map {|category| category.products}.flatten

    end


    private

    def set_product
      @product = Product.friendly.find(params[:id])
    end

  end