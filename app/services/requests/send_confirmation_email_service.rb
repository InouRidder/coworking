# frozen_literal_string: true

module Requests
  class SendConfirmationEmailService < BaseService
    attr_reader :request
    def initialize(request)
      @request = request
    end

    def call
      send_email && update_status
    end

    private

    def send_email
      RequestMailer.with(request: request).send_confirmattion_email.deliver_later
    end

    def update_status
      request.update(last_confirmation_email_sent_at: Date.today)
    end
  end
end

