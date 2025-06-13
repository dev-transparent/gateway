class Graphql::Create < ApiAction
  post "/graphql" do
    OpenTelemetry.tracer.in_span("transparent.request") do |span|
      config = Gateway::ConfigLoader.for_request(request)

      # Parse the query to generate the AST
      query = Oxide::Query.from_json(params.body)
      query.document(max_tokens: config.parsing.try &.max_tokens)

      # Forward the query to upstream
      client = HTTP::Client.new(config.upstream)

      request = OpenTelemetry.tracer.in_span("transparent.operation") do |span|
        headers = HTTP::Headers.new

        OpenTelemetry::Propagation::TraceContext.new(span.context).inject(headers)

        client.post(
          path: config.upstream.path,
          body: params.body,
          headers: headers
        ).tap do |request|
          # Add query information to the trace
          if operation_name = query.operation_name
            span["transparent.operation_name"] = operation_name
          end

          span["transparent.query"] = query.query_string
          span["transparent.method"] = "POST"
          span["transparent.status_code"] = request.status_code
          span["transparent.response_size"] = request.body.bytesize
        end
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
