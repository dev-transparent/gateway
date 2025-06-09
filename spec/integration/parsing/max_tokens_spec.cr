require "../../spec_helper"

describe "max tokens" do
  around_each do |example|
    config = create_default_config
    config.parsing = Gateway::ParsingConfig.from_json("{ \"max_tokens\": 10 }")

    with_gateway_config(config) do
      example.run
    end
  end

  it "returns an error if the number of tokens is over the limit during parsing" do
    query = <<-QUERY
      {
        viewer {
          a: id
          b: id
          c: id
          d: id
          e: id
          f: id
        }
      }
    QUERY

    response = ApiClient.new.graphql(query)
    response.should send_json(200, errors: {
      "message" => "Syntax Error: Document contains more than 10 tokens",
      "locations" => [{"line" => 5, "column" => 8}]
    })
  end

  it "does not return an error if query has less than token limit" do
    query = <<-QUERY
      {
        viewer {
          id
        }
      }
    QUERY

    response = ApiClient.new.graphql(query)
    response.should send_json(200, data: {
      "viewer" => {
        "id" => "1"
      }
    })
  end
end
