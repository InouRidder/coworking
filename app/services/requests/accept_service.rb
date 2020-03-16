# frozen_literal_string: true

module Requests
  class AcceptService < BaseService
    NO_DESK_AVAILABLE = 'no desk available'.freeze
    UNACCEPTABLE_STATUS = 'request needs to be confirmed to be accepted'.freeze

    attr_reader :request, :desk, :user, :contract
    def initialize(request)
      @request = request
    end

    def call
      return request unless validate!

      find_available_desk && create_user && create_contract && update_status
    end

    private

    def find_available_desk
      @desk = Desk.first_available
      return @desk if @desk

      request.errors.add(:base, NO_DESK_AVAILABLE)
      false
    end

    def create_user
      @user = User.create(registration: request.registration)
    end

    def create_contract
      @contract = Contracts::CreateService.call(user: user, desk: desk)
    end

    def update_status
      request.update(status: 'accepted')
    end

    def validate!
      return true if request.confirmed?

      request.errors.add(:base, UNACCEPTABLE_STATUS)
    end
  end
end
