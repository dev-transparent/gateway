class Graphiql::Index < ApiAction
  include DevelopmentOnly

  get "/graphiql" do
    data {{ read_file("#{__DIR__}/index.html") }},
      disposition: "inline",
      content_type: "text/html"
  end
end
