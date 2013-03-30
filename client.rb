# require "logger"
require "base64"
require "multi_json"
require "faraday"

module Browserstack
  class Configuration
    attr_accessor :username, :password
    
    def version; 3; end
    
    def hostname
      @hostname ||= "http://api.browserstack.com"
    end

    def hostname= host
      @hostname = host
    end
  end

  class Client
    attr_accessor :config
    attr_accessor :connection
    
    def initialize(username, password, config=nil)
      if config
        @config = config
      else
        @config = Configuration.new
        @config.username = username
        @config.password = password
      end
      @connection = create_new_connection
    end

    def schema
      parse(connection.get "/#{config.version}")
    end

    def browsers
      parse(connection.get "/#{config.version}/browsers")
    end

    def create_worker(args = {})
      raise ArgumentError if args[:os].nil? 
      raise ArgumentError if args[:browser].nil?

      debugger
      connection.post "/#{config.version}/worker", os: args[:os], browser: args[:browser]
    end

    private
    def create_new_connection      
      conn = Faraday.new(:url => config.hostname) do |faraday|
        faraday.response :logger                  # log requests to STDOUT

        # faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        faraday.adapter  :excon
      end
      conn.basic_auth("kannan.deepak@gmail.com", "<password>")
      conn
    end

    def parse(response)
      MultiJson.load(response.body, :symbolize_keys => true)
    end    
  end
end
