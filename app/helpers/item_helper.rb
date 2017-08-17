module ItemHelper
  def comment_poll_name_display?
    request.path_info.include?("user") and request.path_info.include?("comments")
  end

  def status
    if @item.relationships.nil? and @item.reverse_relationships.nil?
      content_tag :p, "Món đồ này chưa có để nghị đổi nào."
    else
      if @item.reverse_relationships.first.status == "accept" or @item.relationships.first.status == "accept"
        content_tag(:i,"", class: "fa fa-exchange fa-3x")
      elsif @item.demander_items.first
        content_tag(:i,"", class: "fa fa-long-arrow-left fa-3x")
      else
        content_tag :i,"", class: "fa fa-long-arrow-right fa-3x"
      end
    end
  end


  def status
    if @item.relationships.present?

  end
end
