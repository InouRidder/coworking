require 'rails_helper'

RSpec.describe Desks::DistributionJob, type: :job do
  let(:job) { Desks::DistributionJob }
  let(:request) { create(:request, status: 'confirmed') }

  before(:each) do
    3.times { create(:desk) }
  end

  describe '#perform' do
    it 'should accept new users into the coworking as soon as there are desks available' do
      request
      job.perform_now

      expect(request.reload.accepted?).to be_truthy
    end

    it 'should place an accepted user at a desk' do
      request
      job.perform_now

      user = request.registration.user
      contract = user.contracts.last

      expect(user).to be_a User
      expect(contract.desk).to be_a Desk
      expect(contract.ongoing?).to be_truthy
    end

    it 'should only accept confirmed requests' do
      request
      unconfirmed_request = create(:request, status: 'unconfirmed')
      job.perform_now

      expect(request.reload.accepted?).to be_truthy
      expect(unconfirmed_request.reload.accepted?).to be_falsy
    end
  end
end
