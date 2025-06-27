module DevelopmentOnly
  macro included
    before ensure_not_production
  end

  private def ensure_not_production
    if LuckyEnv.production?
      raise Lucky::RouteNotFoundError.new(context)
    else
      continue
    end
  end
end
