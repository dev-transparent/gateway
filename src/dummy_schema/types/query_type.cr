module DummySchema
  QueryType = Oxide::Types::ObjectType.new(
    name: "Query",
    fields: {
      "viewer" => Oxide::Field.new(
        type: Oxide::Types::NonNullType.new(
          of_type: ViewerType
        ),
        resolve: ->(object : Nil, resolution : Oxide::Resolution) {
          Viewer.new(id: "1")
        }
      )
    }
  )
end
