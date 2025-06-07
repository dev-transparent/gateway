module Gateway
  class DummyConfigLoader < ConfigLoader
    def initialize
      @config = Config.new(upstream: URI.parse("http://localhost:3000/dummy"))
    end

    def for_request(request : HTTP::Request) : Config
      @config
    end
  end
end
