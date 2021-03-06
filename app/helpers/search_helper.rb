module SearchHelper
  def get_last_search kind
    if params[:filtering]
      case kind
      when :category
        return params[:filtering][:category]
      when :location
        return params[:filtering][:location]
      when :query
        return params[:filtering][:query]
      when :demandable
        return params[:filtering][:demandable]
      else
        nil
      end
    else
      nil
    end
  end
end
