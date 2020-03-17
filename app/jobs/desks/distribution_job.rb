# frozen_literal_string: true

module Desks
  # Job in charge of distributing free desks to confirmed requests
  class DistributionJob < ApplicationJob
    queue_as :default

    def perform
      Request.confirmed.in_waiting_list_order.each do |request|
        request.accept! # will break from execution  if there no is desk available

        # I'm oke with this iterative query, assuming a coworking won't have that many desks
        break unless Desk.any_available?
      end
    end
  end
end
