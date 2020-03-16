# frozen_literal_string: true

# Contract is the literal contract between a user and the coworking, mitigated through
# the rental of a desk. Contracts get automatically renewed at the end of the month
# for the user, unless the user has decided to inactivate his account.
class Contract < ApplicationRecord
  belongs_to :user
  belongs_to :desk

  STATUSES = {
    paid: 'paid',
    unpaid: 'unpaid'
  }

  enum status: STATUSES

  def ongoing?
    end_date >= Date.today
  end

  def set_total_price
    self.total_price = duration_in_days * desk.price_per_day
  end

  private

  def duration_in_days
    (end_date - start_date).to_i
  end
end
