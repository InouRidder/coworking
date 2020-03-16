# frozen_literal_string: true

# User model is in charge of all relations of onboarded users to contracts and desks and
# extension here on after. The registration model should just keep initial registration information
# but should not relate to any data that can be created after a request is accepted.
class User < ApplicationRecord
  belongs_to :registration

  enum status: {
    active: 'active',
    inactive: 'inactive'
  }
end
