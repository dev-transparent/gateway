module Gateway
  class DummyConfigLoader < ConfigLoader
    def initialize
      json = <<-CONFIG
        {
          "upstream": "http://localhost:3005/dummy"
        }
      CONFIG

      @config = Config.from_json(json)
    end

    def for_request(request : HTTP::Request) : Config
      @config
    end
  end
end
