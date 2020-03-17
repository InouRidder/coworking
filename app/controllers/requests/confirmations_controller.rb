# frozen_literal_string: true

module Requests
  # controller in charge of reconfirming interets of qeued requests
  class ConfirmationsController < ApplicationController
    before_action :set_request

    def update
      Requests::UpdateService.call(@request)
      redirect_to root_path, notice: 'Succesfully reconfirmed!'
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
