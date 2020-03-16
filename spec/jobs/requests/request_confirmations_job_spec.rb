require 'rails_helper'

RSpec.describe Requests::RequestConfirmationsJob, type: :job do
  let(:job) { Requests::RequestConfirmationsJob }
  let(:create_10_confirmed_requests_that_need_reconfirmation) do
    10.times do
      create(:request, status: 'confirmed', last_confirmation_email_sent_at: Date.today - 11.weeks)
    end
  end



  describe '#perform' do
    it 'should send an email to all unconfirmed requests' do
      create_10_confirmed_requests_that_need_reconfirmation

      expect {
        job.perform_now
      }.to change { ActionMailer::Base.deliveries.count }.by(10)
    end

    it 'should update #last_confirmation_email_sent_at attribute for the request' do
      create_10_confirmed_requests_that_need_reconfirmation
      job.perform_now

      expect(
        Request.confirmed.all? { |request| request.last_confirmation_email_sent_at == Date.today }
      ).to be_truthy
    end

    it 'should not send an email to a request with a status other than confirmed' do
      create(:request, status: 'accepted')

      expect {
        job.perform_now
      }.to change { ActionMailer::Base.deliveries.count }.by(0)
    end

    it 'should not update the last_confirmation_email_sent_at value of a request with a status other than confirmed' do
      request = create(:request, status: 'accepted')
      expected = request.last_confirmation_email_sent_at
      job.perform_now

      expect(request.last_confirmation_email_sent_at).to eq(expected)
    end
  end
end
