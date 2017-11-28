class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    before_filter :set_search

    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.json { head :forbidden, content_type: 'text/html' }
        format.html { redirect_to main_app.root_url, notice: exception.message }
        format.js   { head :forbidden, content_type: 'text/html' }
      end
    end
    def set_search
        @q=Product.ransack(params[:q])
    end
end

