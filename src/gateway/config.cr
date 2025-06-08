require "json"
require "uri/json"

module Gateway
  struct ParsingConfig
    include JSON::Serializable

    property max_tokens : Int32? = nil
  end

  struct Config
    include JSON::Serializable

    property upstream : URI
    property parsing : ParsingConfig?
  end
end
