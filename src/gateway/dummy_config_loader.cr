module Gateway
  class DummyConfigLoader < ConfigLoader
    def initialize
      json = <<-CONFIG
        {
          "upstream": "http://localhost:3000/dummy",
          "parsing": {
            "max_tokens": 100
          }
        }
      CONFIG

      @config = Config.from_json(json)
    end

    def for_request(request : HTTP::Request) : Config
      @config
    end
  end
end
