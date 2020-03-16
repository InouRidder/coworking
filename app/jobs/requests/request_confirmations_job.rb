# frozen_literal_string: true

module Requests
  # this Job is in charge of sending confirmation emails to users
  class RequestConfirmationsJob < ApplicationJob
    queue_as :default

    def perform
      Request.confirmed.in_waiting_list_order.includes(:registration).each_with_index do |request, index|

        if request.should_reconfirm?
          Requests::SendConfirmationEmailService.call(request: request, position: index + 1)
        end
      end
    end
  end
end
