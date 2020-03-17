# frozen_literal_string: true

# Desk model all data related to the rentable object desks for the co-working
class Desk < ApplicationRecord
  has_many :contracts
  has_many :users, through: :contracts

  def available?
    contracts.none?(&:ongoing?)
  end

  def taken?
    current_user.present?
  end

  def current_user
    @current_user ||= users.last
  end

  class << self
    def first_available
      includes(:contracts).find(&:available?)
    end

    def any_available?
      any?(&:available?)
    end

    def available
      includes(:contracts).select(&:available?)
    end
  end
end
