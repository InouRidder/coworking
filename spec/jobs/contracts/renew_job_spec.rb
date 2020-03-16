require 'rails_helper'

RSpec.describe Contracts::RenewJob, type: :job do
  describe '#perform' do
    it 'should renew contracts of users that are still active' do
    end

    it 'should not renew contracts for users that went inactive' do
    end

    it 'should free the desk to available again' do
    end
  end
end
