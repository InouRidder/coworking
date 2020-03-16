require 'rails_helper'

RSpec.describe Contract, type: :model do
  it do
    should define_enum_for(:status).
      with_values(
        Contract::STATUSES
      ).
      backed_by_column_of_type(:string)
  end

  describe '#ongoing?' do
    it 'should return true for an ongoing contract' do
      contract = build(:contract)
      expect(contract.ongoing?).to be_truthy
    end

    it 'should return false for an old contract' do
      contract = build(:contract, :expired)
      expect(contract.ongoing?).to be_falsy
    end
  end

  describe '#set_total_price' do
    it 'should set the total price based on start_date, end_date and the price of a desk' do
      desk = build(:desk, price_per_day: 5)
      contract = build(:contract, desk: desk, start_date: Date.today, end_date: Date.today + 10)
      contract.set_total_price

      expect(contract.total_price).to eq(10 * desk.price_per_day)
    end
  end
end
