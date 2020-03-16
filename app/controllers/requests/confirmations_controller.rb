# frozen_literal_string: true

module Requests
  # controller in charge of reconfirming interets of qeued requests
  class ConfirmationsController < ApplicationController
    before_action :set_request

    def update
      Requests::UpdateService.call(@request)
      head :no_content
    end

    private

    def set_request
      @request = Request.find_by_token(token)
    end

    def token
      params.require(:token)
    end
  end
end
