class CartsController < ApplicationController

  layout 'site'

  def index
    current_order
  end

end