require 'rails_helper'

RSpec.describe User, type: :model do
  it do
    should define_enum_for(:status).
      with_values(
        User::STATUSES
      ).
      backed_by_column_of_type(:string)
  end
end
