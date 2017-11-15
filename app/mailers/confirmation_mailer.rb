class ConfirmationMailer < ApplicationMailer


  def registration_confirmation(guest)
    @guest = guest
    @login = "www.example.com"
    mail(:to => "#{guest.email}", :subject => "Registration Confirmation")

 end
end
