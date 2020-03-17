# frozen_literal_string: true

module Contracts
  # Job in charge of renewing contracts
  # should only renew contracts of which the user is still active. Going inactive is opting out of contract renewal
  class RenewJob < ApplicationJob
    queue_as :default

    def perform
      Contract.renewable.each do |contract|
        contract.renew! if contract.should_be_renewed?

        contract.expired! if contract.should_expire?
      end
    end
  end
end
