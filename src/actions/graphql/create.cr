class Graphql::Create < ApiAction
  post "/graphql" do
    config = Gateway::ConfigLoader.for_request(request)

    # Parse the query to generate the AST
    query = Oxide::Query.from_json(params.body)

    # Forward the query to upstream
    client = HTTP::Client.new(config.upstream)

    response = client.post(
      path: config.upstream.path,
      body: params.body
    )

    raw_json response.body
  rescue ex : Oxide::Error
    json Oxide::CombinedError.new([ex])
  end
end
