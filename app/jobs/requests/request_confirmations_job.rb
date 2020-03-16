# frozen_literal_string: true

module Requests
  # this Job is in charge of sending confirmation emails to users
  class RequestConfirmationsJob < ApplicationJob
    queue_as :default

    def perform
      Request.confirmed.includes(:registration).each do |request|
        if request.last_confirmation_email_sent_at <= Date.today - 10.weeks # allowing a 2 week window to confirm
          Requests::SendConfirmationEmailService.call(request)
        end
      end
    end
  end
end
