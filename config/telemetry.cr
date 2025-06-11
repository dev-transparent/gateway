OpenTelemetry.configure do |config|
  config.service_name = "transparent-gateway"
  config.service_version = "0.0.1"

  if LuckyEnv.development?
    config.exporter = OpenTelemetry::Exporter.new(variant: :http) do |exporter|
      exporter = exporter.as(OpenTelemetry::Exporter::Http)
      exporter.endpoint = "http://localhost:3000/metrics"
    end
  else
    config.exporter = OpenTelemetry::Exporter.new(variant: :stdout)
  end
end
