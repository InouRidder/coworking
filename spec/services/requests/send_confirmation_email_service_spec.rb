require 'rails_helper'

RSpec.describe Requests::SendConfirmationEmailService, type: :unit do
  let(:request) { create(:request, status: 'unconfirmed') }
  describe '#call' do
    it 'should send an email' do
      expect {
        Requests::SendConfirmationEmailService.call(request)
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'should update the last_confirmation_email_sent_at to the current date' do
      Requests::SendConfirmationEmailService.call(request)

      expect(request.last_confirmation_email_sent_at).to eq(Date.today)
    end
  end
end
