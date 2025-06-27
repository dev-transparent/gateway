class Graphiql::Index < ApiAction
  before ensure_not_production

  get "/graphiql" do
    data {{ read_file("#{__DIR__}/index.html") }},
      disposition: "inline",
      content_type: "text/html"
  end

  private def ensure_not_production
    if LuckyEnv.production?
      raise Lucky::RouteNotFoundError.new(context)
    else
      continue
    end
  end
end
