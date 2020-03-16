require 'rails_helper'

RSpec.describe Contracts::Creator, type: :unit do
  let(:creator) { Contracts::Creator }
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
