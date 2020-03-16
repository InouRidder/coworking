# frozen_literal_string: true

# Contract is the literal contract between a user and the coworking, mitigated through
# the rental of a desk. Contracts get automatically renewed at the end of the month
# for the user, unless the user has decided to inactivate his account.
class Contract < ApplicationRecord
  belongs_to :user
  belongs_to :desk

  enum status: {
    paid: 'paid',
    unpaid: 'unpaid'
  }
end