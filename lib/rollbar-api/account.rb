module RollbarApi
  class Account
    @@accounts = {}

    def self.configure(account_name, account_access_token)
      @@accounts[account_name] = account_access_token
    end

    def self.find(account_name)
      account_access_token = @@accounts[account_name]
      new(account_name, account_access_token) if account_access_token.present?
    end

    def self.all
      @@accounts.map { |account_name, _| find(account_name) }
    end

    def self.delete_all
      @@accounts = {}
    end

    attr_reader :name, :access_token
    def initialize(name, access_token)
      @name = name
      @access_token = access_token
    end

    %i(get post put delete head patch).each do |http_method|
      define_method(http_method) do |path, params = {}|
        params[:access_token] = access_token
        response = Request.new(method: http_method, path: path, params: params).execute
        if response.is_a?(Array)
          response.map { |r| Resource.new(r) }
        else
          Resource.new(response)
        end
      end
    end
  end
end
