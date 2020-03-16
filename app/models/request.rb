# frozen_literal_string: true

# Request objects keep track of the state of a requested registration for freelancers.
class Request < ApplicationRecord
  has_secure_token

  belongs_to :registration

  STATUSES = {
    unconfirmed: 'unconfirmed',
    confirmed: 'confirmed',
    expired: 'expired',
    accepted: 'accepted'
  }

  enum status: STATUSES

  def accept!
    Requests::AcceptService.call(self)
  end
end
