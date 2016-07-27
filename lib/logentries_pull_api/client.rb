module LogentriesPullApi
  class Client

    attr_reader :account_key, :log_set_key, :log_key

    def initialize(account_key, log_set_key, log_key)
      @account_key = account_key
      @log_set_key = log_set_key
      @log_key = log_key
    end

  end
end