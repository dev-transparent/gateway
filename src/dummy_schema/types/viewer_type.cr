module DummySchema
  ViewerType = Oxide::Types::ObjectType.new(
    name: "Viewer",
    fields: {
      "id" => Oxide::Field.new(
        type: Oxide::Types::NonNullType.new(
          of_type: Oxide::Types::StringType.new
        ),
        resolve: ->(object : Viewer, resolution : Oxide::Resolution) {
          object.id
        }
      )
    }
  )
end
