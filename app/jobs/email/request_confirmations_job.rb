class Email::RequestConfirmationsJob < ApplicationJob
  queue_as :default

  def perform
    Request.unconfirmed.includes(:registration).each do |request|
      Requests::SendConfirmationEmailService.call(request)
    end
  end
end
