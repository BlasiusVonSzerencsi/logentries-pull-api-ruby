require 'spec_helper'

describe LogentriesPullApi::Client do

  subject { described_class.new 'my_account_key', 'my_log_set_key', 'my_log_key' }

  describe '#account_key' do
    it 'should return the configured account key' do
      expect(subject.account_key).to eq 'my_account_key'
    end
  end


  describe '#log_set_key' do
    it 'should return the configured log set key' do
      expect(subject.log_set_key).to eq 'my_log_set_key'
    end
  end


  describe '#log_key' do
    it 'should return the configured log key' do
      expect(subject.log_key).to eq 'my_log_key'
    end
  end

end
