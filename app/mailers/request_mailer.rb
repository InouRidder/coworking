# frozen_literal_string: true

class RequestMailer < ApplicationMailer
  def send_confirmation_email
    @request = params[:request]
    @registration = @request.registration
    mail(to: @registration.email, subject: 'Confirm your email!')
  end
end
