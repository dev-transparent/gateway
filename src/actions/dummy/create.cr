class Dummy::Create < ApiAction
  post "/dummy" do
    query = Oxide::Query.from_json(params.body)

    validations = Oxide::Validation::Runtime.new(DummySchema::Schema, query)
    validations.execute!

    runtime = Oxide::Execution::Runtime.new(DummySchema::Schema)

    json runtime.execute(
      query: query,
      initial_value: nil
    )
  rescue ex : Oxide::CombinedError
    json ex
  rescue ex : Oxide::Error
    json Oxide::CombinedError.new([ex])
  end
end
