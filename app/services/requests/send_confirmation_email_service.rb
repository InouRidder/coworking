# frozen_literal_string: true

module Requests
  class SendConfirmationEmailService < BaseService
    attr_reader :request, :position
    def initialize(attributes)
      @request = attributes[:request]
      @position = attributes[:position]
    end

    def call
      send_email
      update_status
    end

    private

    def send_email
      RequestMailer.with(
        request: request,
        position: position
      ).send_confirm_interest.deliver_now # TODO: deliver_later
    end

    def update_status
      request.update(last_confirmation_email_sent_at: Date.today)
    end
  end
end

