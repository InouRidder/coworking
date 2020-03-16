# frozen_literal_string: true

module Contracts
  class Creator < BaseService
    attr_reader :contract, :desk, :user
    def initialize(attrs)
      @desk = attrs[:desk]
      @user = attrs[:user]
    end

    def call
      new_contract && contract.set_total_price
      contract.save
      contract
    end

    private

    def new_contract
      @contract = Contract.new(
        user: user,
        desk: desk,
        start_date: Date.today,
        end_date: Date.today.end_of_month,
      )
    end
  end
end
