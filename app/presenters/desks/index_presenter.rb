# frozen_literal_string: true

module Desks
  class IndexPresenter < BasePresenter
    def waiting_list
      @waiting_list ||= Request.includes(:registration).waiting_list
    end

    def desks
      @desks ||= Desk.includes(users: :registration)
    end
  end
end
