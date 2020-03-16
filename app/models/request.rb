# frozen_literal_string: true

# Request objects keep tracking of the state of a requested registration for freelancers.
class Request < ApplicationRecord
  enum status: {
    unconfirmed: 'unconfirmed',
    confirmed: 'confirmed',
    expired: 'expired',
    accepted: 'accepted'
  }

  def accept!
  end
end
