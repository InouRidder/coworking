require "rails_helper"

RSpec.describe RequestMailer, type: :mailer do
  let(:request) { create(:request, status: 'confirmed') }
  let(:position) { Request.waiting_list.index(request) + 1}
  let(:mail) { RequestMailer.with(request: request, position: position).send_confirm_interest }
  describe "send_confirm_interest" do

    it "renders the headers" do
      expect(mail.subject).to eq('Are you still interested?')
      expect(mail.to).to eq([request.registration.email])
      expect(mail.from).to eq(['contact@coworking.com'])
    end

    it "renders the body (including the waitling list position)" do
      request
      expect(mail.body.encoded).to match("current position in qeue: #{position}")
    end
  end

end
