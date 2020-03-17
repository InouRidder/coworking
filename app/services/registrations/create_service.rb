# frozen_literal_string: true

module Registrations
  class CreateService < BaseService
    attr_reader :registration, :params
    def initialize(attrs)
      @params = attrs[:params]
    end

    def call
      create_registration && create_request
      registration
    end

    private

    def create_registration
      @registration = Registration.create(registration_params)
    end

    def temp_password
      Devise.friendly_token.first(8)
    end

    def create_request
      Request.create(registration: registration) if registration.persisted?
    end

    def registration_params
      @registration_params ||= params.merge!(
        password: temp_password
      )
    end
  end
end
