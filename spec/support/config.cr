def create_default_config : Gateway::Config
  json = <<-CONFIG
    {
      "upstream": "http://localhost:3005/dummy"
    }
  CONFIG

  Gateway::Config.from_json(json)
end

def with_gateway_config(config : Gateway::Config, &blk)
  loader = Gateway::ConfigLoader.settings.loader

  unless loader.is_a?(Gateway::TestConfigLoader)
    raise "Config loader must be a Gateway::TestConfigLoader instance"
  end

  loader.with_config(config, &blk)
end
