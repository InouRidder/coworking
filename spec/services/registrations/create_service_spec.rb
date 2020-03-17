require 'rails_helper'

RSpec.describe Registrations::CreateService, type: :unit do
  let(:service) { Registrations::CreateService }
  let(:registration) { build(:registration) }
  let(:params) do
    ActionController::Parameters.new(registration.attributes.except('id', 'updated_at', 'created_at'))
  end

  describe '#call' do
    it 'should create a registration and a request' do
      registration = service.call(params: params.permit!)

      expect(registration.persisted?).to be_truthy
    end

    it 'should return a registration with errors for invalid params' do
      local_params = params.permit!
      local_params[:phone] = '123'
      local_params[:bio] = 'bio too short'
      registration = service.call(params: local_params)

      expect(registration.persisted?).to be_falsy
      expect(registration.errors.keys).to include(*[:phone, :bio])
    end

    it 'should fail if passed unpermitted params' do
      expect {
        service.call(params: params)
      }.to raise_error ActiveModel::ForbiddenAttributesError
    end
  end
end
