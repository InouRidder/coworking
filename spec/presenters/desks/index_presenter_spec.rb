require 'rails_helper'

RSpec.describe Desks::IndexPresenter, type: :unit do
  let(:presenter) { Desks::IndexPresenter.new }
  let(:unconfirmed_request) { create(:request, status: 'unconfirmed') }
  let(:confirmed_request) { create(:request, status: 'confirmed') }

  describe '#waiting_list' do
    it 'should the waiting list with associations eager loaded' do
      confirmed_request
      list = presenter.waiting_list
      expect(list.first.association(:registration).loaded?).to be_truthy
    end

    it 'should not include non waiting list requests' do
      confirmed_request
      unconfirmed_request
      list = presenter.waiting_list
      expect(list).not_to include(unconfirmed_request)
      expect(list).to include(confirmed_request)
    end
  end

  describe '#desks' do
    it 'should return all the desks' do
    end

    it 'should return all the desks with preloaded association' do
      create(:desk)
      list = presenter.desks

      expect(list.first.association(:contracts).loaded?).to be_truthy
    end
  end
end
