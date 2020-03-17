require 'rails_helper'

RSpec.describe Registration, type: :model do
  let(:registration) { build(:registration) }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with an invalid email' do
      subject.email = 'not-an-email'
      expect(subject).to_not be_valid
    end

    it "is not valid without a phone number" do
      subject.phone = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with an invalid phone number' do
      subject.phone = '+32123'
      expect(subject).to_not be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a bio' do
      subject.bio = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a short bio' do
      subject.bio = 'too short'
      expect(subject).to_not be_valid
    end
  end
end
