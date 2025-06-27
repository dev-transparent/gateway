Gateway::ConfigLoader.configure do |settings|
  if LuckyEnv.development? || LuckyEnv.production?
    settings.loader = Gateway::DummyConfigLoader.new
  elsif LuckyEnv.test?
    settings.loader = Gateway::TestConfigLoader.new
  end
end
