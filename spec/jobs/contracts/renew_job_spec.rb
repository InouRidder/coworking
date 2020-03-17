require 'rails_helper'

RSpec.describe Contracts::RenewJob, type: :job do
  let(:job) { Contracts::RenewJob }
  let(:contract_to_be_renewed) { create(:contract, end_date: Date.today, status: 'paid') }
  let(:active_contract) { create(:contract, end_date: Date.today - 1.week, status: 'unpaid') }
  let(:expired_contract) { create(:contract, status: 'paid', end_date: Date.today + 1.week) }

  describe '#perform' do
    it 'should renew contracts of users that are still active' do
      contract_to_be_renewed

      expect {
        job.perform_now
      }.to change { contract_to_be_renewed.user.contracts.count }.by(1)
    end

    it 'should expire paid contracts that are passed the end_date' do
      expired_contract
      job.perform_now

      expect(expired_contract.reload.expired?).to be_truthy
    end

    it 'should not renew active contracts' do
      active_contract

      expect {
        job.perform_now
      }.to change { active_contract.user.contracts.count }.by(0)
      expect(active_contract.reload.expired?).to be_falsy
    end

    it 'should not renew expired contracts' do
      expired_contract

      expect {
        job.perform_now
      }.to change { expired_contract.user.contracts.count }.by(0)
    end

    it 'should not renew contracts of inactive users' do
      user = create(:user, status: 'inactive')
      create(:contract, user: user, end_date: Date.today)

      expect {
        job.perform_now
      }.to change { user.contracts.count }.by(0)
    end

    it 'should free the desk to available again' do
    end
  end
end
