# frozen_literal_string: true

# Request objects keep track of the state of a requested registration for freelancers.
class Request < ApplicationRecord
  has_secure_token

  belongs_to :registration

  scope :in_waiting_list_order, -> { order(created_at: :desc) }

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

  def should_reconfirm?
    last_confirmation_email_sent_at <= Date.today - 10.weeks # allowing a 2 week window to confirm
  end

  def should_expire?
    last_confirmed_at <= Date.today - 3.months
  end
end
