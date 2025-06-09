module Gateway
  class TestConfigLoader < ConfigLoader
    def with_config(config : Config)
      original_config = @config
      @config = config
      yield
    ensure
      if original_config
        @config = original_config
      end
    end

    def for_request(request : HTTP::Request) : Config
      config = @config

      unless config
        raise "Config must be set for gateway using `with_gateway_config`"
      end

      config.not_nil!
    end
  end
end
