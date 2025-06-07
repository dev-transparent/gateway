module Gateway
  abstract class ConfigLoader
    Habitat.create do
      setting loader : ConfigLoader
    end

    def self.for_request(request : HTTP::Request) : Config
      settings.loader.for_request(request)
    end

    abstract def for_request(request : HTTP::Request) : Config
  end
end
