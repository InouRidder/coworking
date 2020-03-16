# frozen_literal_string: true

# Request objects keep track of the state of a requested registration for freelancers.
class Request < ApplicationRecord
  belongs_to :registration

  STATUSES = {
    unconfirmed: 'unconfirmed',
    confirmed: 'confirmed',
    expired: 'expired',
    accepted: 'accepted'
  }

  enum status: STATUSES

  def accept!
    Requests::Acceptor.call(self)
  end
end
