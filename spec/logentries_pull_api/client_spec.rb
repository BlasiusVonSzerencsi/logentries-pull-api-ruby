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


  describe '#get' do

    before { allow(Net::HTTP).to receive(:get_response) }

    it 'should assemble a proper LogEntries API URL' do
      expect(URI).to receive(:parse)
                         .with 'https://pull.logentries.com/my_account_key/hosts/my_log_set_key/my_log_key/'

      subject.get
    end


    it 'should URL encode log set and log keys' do
      subject = described_class.new 'some_account_key', 'my log set key with whitespaces', 'log key with whitespaces'

      expect(URI).to receive(:parse)
                         .with 'https://pull.logentries.com/some_account_key/hosts/my%20log%20set%20key%20with%20whitespaces/log%20key%20with%20whitespaces/'

      subject.get
    end


    it 'should make a HTTP request to the assembled URL' do
      uri = instance_double URI

      allow(URI).to receive(:parse).and_return uri
      expect(Net::HTTP).to receive(:get_response).with uri

      subject.get
    end

  end

end
