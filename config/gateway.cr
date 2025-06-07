Gateway::ConfigLoader.configure do |settings|
  settings.loader = Gateway::DummyConfigLoader.new
end
