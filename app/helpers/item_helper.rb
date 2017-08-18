module ItemHelper
  def comment_poll_name_display?
    request.path_info.include?("user") and request.path_info.include?("comments")
  end

  def status
    if @item.relationships.present?
      if @item.relationships.first.status == "accepted"
        content_tag(:i, "", class: "fa fa-exchange")
      else
        # content_tag(:i, "", class: "fa fa-long-arrow-right") +
        available_action
      end
    elsif @item.reverse_relationships.present?
      # content_tag(:i, "", class: "fa fa-long-arrow-left") +
      available_action
    else
      content_tag(:p, "nothing")
    end
  end

  def available_action
    if owner? @item.user
      content_tag(:div, "", class: "action") do
        if @item.demander_items.present?
          content_tag(:div, "", class: "fa fa-long-arrow-left") +
          form_for(Relationship.new, url: {controller: 'relationships', action: "accept"}) do |f|
            capture do
              concat (f.hidden_field(:demander_id, value: @item.id))
              concat (f.hidden_field(:granter_id, value: @item.demander_items.first.id[0]))
            end +
            button_tag("", type: "submit", class: "btn btn-success accept") do
              content_tag(:i, "", class: "fa fa-long-arrow-right")
            end
          end +
          link_to(content_tag(:i, "", class: "fa fa-times"),
                              deny_relationship_path(id: @item.id, relationship: { granter_id: @item.demander_item_ids[0] }),
                              class: "deny btn btn-danger",
                              method: :delete,
                              data: { :confirm => "Really?" })
        elsif @item.granter_items.present?
          content_tag(:i, "", class: "fa fa-long-arrow-right") +
          tag(:br) +
          link_to(content_tag(:i, "", class: "withhold fa fa-times"),
                              withhold_relationship_path(relationship: { granter_id: @item.id }),
                              class: "withhold btn btn-danger",
                              method: :delete,
                              data: { :confirm => "Really?" })
        end
      end
    end
  end
end
