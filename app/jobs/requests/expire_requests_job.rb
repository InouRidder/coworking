# frozen_literal_string: true

module Requests
  # this Job is in charge of expiring requests that do net get reconfirmed
  class ExpireRequestsJob < ApplicationJob
    queue_as :default

    def perform
      Request.confirmed.each do |request|
        days_since_last_confirmation = (Date.today - request.last_confirmed_at).to_i

        if days_since_last_confirmation > 3.months
          request.expired!
        end
      end
    end
  end
end
