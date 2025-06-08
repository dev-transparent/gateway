class Graphql::Create < ApiAction
  post "/graphql" do
    config = Gateway::ConfigLoader.for_request(request)

    # Parse the query to generate the AST
    query = Oxide::Query.from_json(params.body)
    query.document

    # Forward the query to upstream
    client = HTTP::Client.new(config.upstream)

    request = client.post(
      path: config.upstream.path,
      body: params.body
    )

    # Copy over the headers
    request.headers.each do |key, value|
      response.headers[key] = value
    end

    send_text_response(request.body, request.content_type || "application/json", request.status_code)
  rescue ex : Oxide::Error
    json Oxide::CombinedError.new([ex])
  end
end
