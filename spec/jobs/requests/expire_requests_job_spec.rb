require 'rails_helper'

RSpec.describe Requests::RequestConfirmationsJob, type: :job do

  let(:create_3_confirmed_requests_that_should_expire) do
    3.times do
      create(:request, status: 'confirmed', last_confirmed_at: Date.today - 4.months)
    end
  end

  describe '#perform' do
    it 'should expire all jobs that have not been reconfirmed' do
      create_3_confirmed_requests_that_should_expire

      expect {
        Requests::ExpireRequestsJob.perform_now
      }.to change { Request.expired.count }.by(3)
    end

    it 'should only expire jobs which have not been reconfirmed in 3 months' do
      request = create(:request, status: 'confirmed', last_confirmed_at: Date.today - 1.month)
      Requests::RequestConfirmationsJob.perform_now

      Requests::ExpireRequestsJob.perform_now
      expect(request.confirmed?).to be_truthy
    end
  end
end
