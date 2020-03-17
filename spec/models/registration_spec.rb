require 'rails_helper'

RSpec.describe Registration, type: :model do
  let(:registration) { build(:registration) }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(registration).to be_valid
    end

    it "is not valid without a password" do
      registration.password = nil
      expect(registration).to_not be_valid
    end

    it "is not valid without an email" do
      registration.email = nil
      expect(registration).to_not be_valid
    end

    it 'is not valid with an invalid email' do
      registration.email = 'not-an-email'
      expect(registration).to_not be_valid
    end

    it "is not valid without a phone number" do
      registration.phone = nil
      expect(registration).to_not be_valid
    end

    it 'is not valid with an invalid phone number' do
      registration.phone = '+32123'
      expect(registration).to_not be_valid
    end

    it 'is not valid without a name' do
      registration.name = nil
      expect(registration).to_not be_valid
    end

    it 'is not valid without a bio' do
      registration.bio = nil
      expect(registration).to_not be_valid
    end

    it 'is not valid with a short bio' do
      registration.bio = 'too short'
      expect(registration).to_not be_valid
    end
  end
end
