# frozen_literal_string: true

# Desk model all data related to the rentable object desks for the co-working
class Desk < ApplicationRecord
  has_many :contracts

  def available?
    contracts.none?(&:ongoing?)
  end

  class << self
    def first_available
      includes(:contracts).find(&:available?)
    end

    def any_available?
      any?(&:available?)
    end
  end
end
