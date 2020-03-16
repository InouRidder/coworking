require 'rails_helper'

RSpec.describe Requests::Acceptor, type: :unit do
  let(:request) { build(:request) }
  let(:acceptor) { Requests::Acceptor }

  let(:call_with_desk) do
    create(:desk)
    acceptor.call(request)
  end

  describe '#call' do
    it 'should create a user for that request' do
      call_with_desk

      expect(User.find_by(registration: request.registration)).to be_a User
    end

    it 'should create a contract for that request, if a desk is available' do
      call_with_desk

      expect(Contract.find_by(user: request.registration.user)).to be_a Contract
    end

    it 'should not create a user or a contract if no desk is available' do
      create(:desk, :with_ongoing_contract)
      acceptor.call(request)

      expect(request.errors[:base][0]).to eq(Requests::Acceptor::NO_DESK_AVAILABLE)
      expect(request.registration.user).to be_nil
    end

    it 'should not accept a request that has any other status than confirmed' do
      request = build(:request, status: 'unconfirmed')
      build(:desk)
      acceptor.call(request)

      expect(request.errors[:base][0]).to eq(Requests::Acceptor::UNACCEPTABLE_STATUS)
    end
  end
end
