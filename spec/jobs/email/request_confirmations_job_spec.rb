require 'rails_helper'

RSpec.describe Email::RequestConfirmationsJob, type: :job do
  describe '#perform' do
    it 'should send an email to all unconfirmed requests' do

    end

    it 'should update #last_confirmation_email_sent_at attribute for the request' do

    end
  end
end
