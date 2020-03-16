class RequestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.request_mailer.send_confirm_interest.subject
  #
  def send_confirm_interest
    @request = params[:request]
    @position = params[:position]
    mail to: @request.registration.email, subject: 'Are you still interested?'
  end
end
