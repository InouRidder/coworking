# frozen_literal_string: true

module Desks
  # Job in charge of distributing free desks to confirmed requests
  class DistributionJob < ApplicationJob
    queue_as :default

    def perform
      Desk.available.each do |_desk|
        # Request#accept fetches the first available desk
        # this could be optimized in terms of DB query,
        # but I like the DSL as is
        Request.waiting_list.first&.accept!
      end
    end
  end
end
