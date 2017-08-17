module ItemHelper
  def comment_poll_name_display?
    request.path_info.include?("user") and request.path_info.include?("comments")
  end

  def status
    if @item.relationships.present?
      if @item.relationships.first.status == "accept"
        content_tag(:i, "", class: "fa fa-exchange fa-3x")
      else
        content_tag :i, "", class: "fa fa-long-arrow-right fa-3x"
      end
    elsif @item.reverse_relationships.present?
      form_for Relationship.new(demander_id: @item.id), url: {controller: 'relationships', action: "accept"} do |f|
        hidden_field :demander_id, value: 1
        hidden_field :granter_id, value: @item.demander_items.first.id
        button_tag "", type: "submit", class: "btn btn-success accept"
      end
    else
      content_tag(:p, "nothing")
    end
  end

  def available_action
    if owner? @item.user
      if @item.demander_items.present?
        tag.form class: "new_relationship",
                 id: "new_relationship",
                 action: "relationship/#{@item.id}/accept",
                 "accept-charset": "UTF-8",
                 method: "post"
      end
    end
        #  = form_for Relationship.new(demander_id: @item.id), url: {controller: 'relationships', action: "accept"} do |f|
        #    = f.hidden_field :demander_id
        #    = f.hidden_field :granter_id, value: @item.demander_items.first.id
        #    = button_tag "", type: "submit", class: "btn btn-success accept" do
        #      i.fa.fa-long-arrow-right.fa-3x
        #  .deny
        #    = link_to relationship_path(relationship: { granter_id: @item.demander_items.first }), class: "btn btn-danger", method: :delete, data: { :confirm => "Really?" } do
        #      i.fa.fa-times.fa-3x

  end
end
