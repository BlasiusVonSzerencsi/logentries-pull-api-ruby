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

    let(:uri) { instance_double URI }
    let(:response) { instance_double Net::HTTPResponse }

    it 'should assemble a proper LogEntries API URL' do
      expect(URI).to receive(:parse)
                         .with('https://pull.logentries.com/my_account_key/hosts/my_log_set_key/my_log_key/?format=json')
                         .and_return uri
      allow(Net::HTTP).to receive(:get_response).with(uri).and_return response
      allow(response).to receive(:body).and_return '{}'

      subject.get
    end


    it 'should URL encode log set and log keys' do
      subject = described_class.new 'some_account_key', 'my log set key with whitespaces', 'log key with whitespaces'

      expect(URI).to receive(:parse)
                         .with(/my%20log%20set%20key%20with%20whitespaces\/log%20key%20with%20whitespaces/)
                         .and_return uri

      allow(Net::HTTP).to receive(:get_response).and_return response
      allow(response).to receive(:body).and_return '{}'

      subject.get
    end


    it 'should make a HTTP request to the assembled URL' do
      allow(URI).to receive(:parse).and_return uri
      expect(Net::HTTP).to receive(:get_response).with(uri).and_return response
      allow(response).to receive(:body).and_return '{}'

      subject.get
    end


    it 'should return the parsed entries' do
      allow(URI).to receive(:parse).and_return uri
      allow(Net::HTTP).to receive(:get_response).with(uri).and_return response
      allow(response).to receive(:body).and_return '[{"some_key":"some_value"},{"another_key":"another_value"}]'

      expect(subject.get).to eq [{'some_key' => 'some_value'}, {'another_key' => 'another_value'}]
    end

  end

end
