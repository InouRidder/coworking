# frozen_literal_string: true

module Desks
  # Job in charge of distributing free desks to confirmed requests
  class DistributionJob < ApplicationJob
    queue_as :default

    def perform
      # I realise this is heavy on the DB, but seems the least prone to bug
      while Desk.any_available? && Request.confirmed.any?
        Request.confirmed.in_waiting_list_order.each do |request|
          request.accept!
        end
      end
    end
  end
end
