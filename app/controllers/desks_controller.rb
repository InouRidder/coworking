# frozen_literal_string: true

# Controller in charge of displaying taken desks and the waiting list
class DesksController < ApplicationController
  def index
    @presenter = present
  end
end
