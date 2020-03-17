# frozen_literal_string: true

module Desks
  # Job in charge of distributing free desks to confirmed requests
  class DistributionJob < ApplicationJob
    queue_as :default

    def perform
      Request.confirmed.in_waiting_list_order.each do |request|
        request.accept! # will simply fail if there no is desk available
        break unless Desk.any_available?
      end
    end
  end
end
