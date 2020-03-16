# frozen_literal_string: true

module Requests
  # this Job is in charge of expiring requests that do net get reconfirmed
  class ExpireRequestsJob < ApplicationJob
    queue_as :default

    def perform
      Request.confirmed.each do |request|
        if request.last_confirmed_at <= Date.today - 3.months # expire if not reconfirmed after 3 months
          request.expired!
        end
      end
    end
  end
end
