module Gateway
  struct Config
    include JSON::Serializable

    property upstream : URI

    def initialize(@upstream)
    end
  end
end
