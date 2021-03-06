module ItemHelper
  def comment_item_name_display?
    request.path_info.include?("user") and request.path_info.include?("comments")
  end

  def exchangeable? item
    !owner?(item.user) and !item.demanded? and !item.got_demanded?
  end

  def status item
    content_tag(:div, "", class: "action") do
      if item.demanded?
        if item.is_accepted?
          content_tag(:i, "", class: "fa fa-exchange")
        else
          content_tag(:i, "", class: "fa fa-long-arrow-right") +
          available_action(item)
        end
      elsif item.got_demanded?
        content_tag(:i, "", class: "fa fa-long-arrow-left") +
        available_action(item)
      end
    end
  end

  def withhold item
    button_tag "", {class:"btn btn-danger withhold", 'data-toggle' => "modal", "data-target" => "#withholdModal"} do
      '<i class="fa fa-times"></i>'.html_safe
    end
  end

  def deny item
    button_tag "", {class:"btn btn-danger deny", 'data-toggle' => "modal", "data-target" => "#denyModal"} do
      '<i class="fa fa-times"></i>'.html_safe
    end
  end

  def accept item
    button_tag "", {class:"btn btn-success accept", 'data-toggle' => "modal", "data-target" => "#acceptModal"} do
      '<i class="fa fa-long-arrow-right"></i>'.html_safe
    end
  end

  def available_action item
    if owner? item.user and request.env['PATH_INFO'].include?(item_path(item))
      if item.demander_items.present?
        tag(:br) +
        accept(item) +
        tag(:br) +
        deny(item)
      elsif item.granter_items.present?
        tag(:br) +
        withhold(item)
      end
    end
  end

  def available_render item
    if owner? item.user and request.env['PATH_INFO'].include?(item_path(item))
      concat render "items/del_modal", item: @item
      if item.demander_items.present?
        concat render "relationships/accept_modal", item: @item
        concat render "relationships/deny_modal", item: @item
      elsif item.granter_items.present?
        render "relationships/withhold_modal", item: @item
      end
    end
  end
end
