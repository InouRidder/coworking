require 'rails_helper'

RSpec.describe Request, type: :model do
  let(:request) { build(:request) }
  let(:desk) { build(:desk) }

  it do
    should define_enum_for(:status).
      with_values(
        Request::STATUSES
      ).
      backed_by_column_of_type(:string)
  end

  describe '#accept!' do
    it 'should create a user for that request' do
      create(:desk)
      request.accept!

      expect(User.find_by(registration: request.registration)).to be_a User
    end

    it 'should create a contract for that request, if a desk is available' do
      create(:desk)
      request.accept!

      expect(Contract.find_by(user: request.registration.user)).to be_a Contract
    end

    it 'should not create a user or a contract if no desk is available' do
      request.accept!

      expect(request.errors[:base][0]).to eq('No desk available')
      expect(request.registration.user).to be_nil
    end
  end
end
