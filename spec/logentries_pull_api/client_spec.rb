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

    let(:uri) { instance_double URI::HTTPS }
    let(:response) { instance_double Net::HTTPResponse }

    before do
      allow(URI).to receive(:parse).and_return uri
      allow(uri).to receive(:query=)
      allow(Net::HTTP).to receive(:get_response).with(uri).and_return response
      allow(response).to receive(:body).and_return '[]'
    end

    it 'should assemble a proper LogEntries API URL' do
      expect(URI).to receive(:parse)
                         .with('https://pull.logentries.com/my_account_key/hosts/my_log_set_key/my_log_key/')
                         .and_return uri

      subject.get
    end


    it 'should request logs in JSON format' do
      expect(uri).to receive(:query=).with 'format=json'

      subject.get
    end


    it 'should URL encode log set and log keys' do
      subject = described_class.new 'some_account_key', 'my log set key with whitespaces', 'log key with whitespaces'

      expect(URI).to receive(:parse)
                         .with(/my%20log%20set%20key%20with%20whitespaces\/log%20key%20with%20whitespaces/)
                         .and_return uri

      subject.get
    end


    it 'should make a HTTP request to the assembled URL' do
      expect(Net::HTTP).to receive(:get_response).with(uri).and_return response

      subject.get
    end


    it 'should return the parsed entries' do
      allow(response).to receive(:body).and_return '[{"some_key":"some_value"},{"another_key":"another_value"}]'

      expect(subject.get).to eq [{'some_key' => 'some_value'}, {'another_key' => 'another_value'}]
    end

    context 'when called with parameters' do

      it 'should allow filtering result set with time range' do
        expect(uri).to receive(:query=).with /start=1432080000000&end=1432092600000/

        subject.get start: 1432080000000, end: 1432092600000
      end


      it 'should allow limiting result set size' do
        expect(uri).to receive(:query=).with /limit=123/

        subject.get limit: 123
      end

    end

  end

end
