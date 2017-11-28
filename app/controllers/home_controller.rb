class HomeController < ApplicationController
  layout "site"

  skip_before_action :verify_authenticity_token, only: :create_contact

  def index
     @q = Product.ransack(params[:q])
     @products = @q.result(distinct: true)
  end

  def contact
  end

  def create_contact
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to root_path
    end
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :email, :subject, :message)
    end

end
