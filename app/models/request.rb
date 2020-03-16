# frozen_literal_string: true

# Request objects keep track of the state of a requested registration for freelancers.
class Request < ApplicationRecord
  belongs_to :registration

  enum status: {
    unconfirmed: 'unconfirmed',
    confirmed: 'confirmed',
    expired: 'expired',
    accepted: 'accepted'
  }

  def accept!
    # Onboarding::Onboarder.call(registration: registration)
  end
end
