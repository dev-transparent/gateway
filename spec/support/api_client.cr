class ApiClient < Lucky::BaseHTTPClient
  app AppServer.new

  def initialize
    super
    headers("Content-Type": "application/json")
  end

  def graphql(query : String, variables : Hash(String, JSON::Any)? = {} of String => JSON::Any, operation_name = nil)
    exec_raw(Graphql::Create, Oxide::Query.new(query, variables, operation_name).to_json)
  end
end
