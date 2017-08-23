module SearchHelper
  def get_last_search kind
    if params[:filtering]
      case kind
      when :category
        return params[:filtering][:category]
      when :location
        return params[:filtering][:location]
      when :query
        puts "************************************"
        puts params[:filtering][:demandable]
        return params[:filtering][:query]
      when :demandable
        puts "************************************"
        puts params[:filtering][:demandable]
        return params[:filtering][:demandable]
      else
        nil
      end
    else
      nil
    end
  end
end
