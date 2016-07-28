require 'json'
require 'net/http'

module LogentriesPullApi
  class Client

    attr_reader :account_key, :log_set_key, :log_key

    def initialize(account_key, log_set_key, log_key)
      @account_key = account_key
      @log_set_key = log_set_key
      @log_key = log_key
    end


    def get
      encoded_log_set_key = URI.encode log_set_key
      encoded_log_key = URI.encode log_key

      URI.parse "#{LOGENTRIES_API_URL}/#{account_key}/hosts/#{encoded_log_set_key}/#{encoded_log_key}/"
    end


    private

    LOGENTRIES_API_URL = 'https://pull.logentries.com'

  end
end