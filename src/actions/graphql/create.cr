class Graphql::Create < ApiAction
  post "/graphql" do
    OpenTelemetry.tracer.in_span("graphql") do |span|
      config = Gateway::ConfigLoader.for_request(request)

      # Parse the query to generate the AST
      query = Oxide::Query.from_json(params.body)
      query.document(max_tokens: config.parsing.try &.max_tokens)

      # Forward the query to upstream
      client = HTTP::Client.new(config.upstream)

      request = OpenTelemetry.tracer.in_span("upstream") do
        client.post(
          path: config.upstream.path,
          body: params.body
        )
      end

      # Copy over the headers
      request.headers.each do |key, value|
        response.headers[key] = value
      end

      send_text_response(request.body, request.content_type || "application/json", request.status_code)
    end
  rescue ex : Oxide::Error
    json Oxide::CombinedError.new([ex])
  end
end
