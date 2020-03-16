# frozen_literal_string: true

module Requests
  class UpdateService < BaseService
    attr_reader :request
    def initialize(request)
      @request = request
    end

    def call
      request.update(last_confirmed_at: Date.today)
    end
  end
end
