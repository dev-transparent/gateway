OpenTelemetry.configure do |config|
  config.service_name = "transparent-gateway"
  config.service_version = "0.0.1"
  config.exporter = OpenTelemetry::Exporter.new(variant: :stdout)
end
