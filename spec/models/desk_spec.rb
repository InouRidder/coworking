require 'rails_helper'

RSpec.describe Desk, type: :model do
  let(:desk_available) { build(:desk) }
  let(:desk_unavailable) { build(:desk, :with_ongoing_contract) }

  describe '#available?' do
    it 'should return true if there are no ongoing contracts for the desk' do
      expect(desk_available.available?).to be_truthy
    end

    it 'should return false if there is an ongoing contract' do
      expect(desk_unavailable.available?).to be_falsy
    end
  end

  describe '.first_available' do
    it 'should return the first available desk' do
      available = create(:desk)
      desk_unavailable

      expect(Desk.first_available).to eq(available)
    end

    it 'should return nil if no desk is available' do
      desk_unavailable

      expect(Desk.first_available).to be_nil
    end
  end
end
