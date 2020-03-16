require 'rails_helper'

RSpec.describe Contracts::CreateService, type: :unit do
  let(:creator) { Contracts::CreateService }
  let(:user) { build(:user) }
  let(:desk) { build(:desk) }


  describe '#call' do
    it 'should create a contract' do
      contract = creator.call(user: user, desk: desk)

      expect(contract).to be_a Contract
      expect(contract.status).to eq('unpaid')
      expect(contract.persisted?).to be_truthy
    end
  end
end
