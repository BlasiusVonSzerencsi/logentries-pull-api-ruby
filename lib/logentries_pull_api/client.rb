require 'json'
require 'net/http'
require 'uri'

module LogentriesPullApi

  class Client

    attr_reader :account_key, :log_set_key, :log_key

    def initialize(account_key, log_set_key, log_key)
      @account_key = account_key
      @log_set_key = log_set_key
      @log_key = log_key
    end


    def get(options = {})
      response = fetch_response_from assemble_uri(options)

      raise LogentriesPullApi::Error, response['reason'] if response.is_a? Hash

      response
    end

    private

    LOGENTRIES_API_URL = 'https://pull.logentries.com'


    def assemble_uri(options)
      encoded_log_set_key = URI.encode log_set_key
      encoded_log_key = URI.encode log_key

      uri = URI.parse "#{LOGENTRIES_API_URL}/#{account_key}/hosts/#{encoded_log_set_key}/#{encoded_log_key}/"
      uri.query = URI.encode_www_form options.merge format: 'json'

      uri
    end


    def fetch_response_from(uri)
      response = Net::HTTP.get_response uri
      JSON.parse response.body
    end

  end

  class Error < StandardError; end

end