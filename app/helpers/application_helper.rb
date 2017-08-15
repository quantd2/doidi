module ApplicationHelper
  def full_title(page_title)
    base_title = "Đổi Đi"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.simple_fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields btn btn-primary input-button", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def path_send *arg
    Rails.application.routes.url_helpers.send *arg
  end

  def admin?
    current_user.admin ? true : false
  end

  def meta_description(desc = nil)
    content_for :meta_description, desc
  end

  def owner? user
    current_user and current_user.email == user.email
  end

  def link_to_reply(name, comment)
    id = comment.id
    fields = simple_form_for Comment.new(parent_id: id), html: { id: comment.normalized_id}, validate: true, remote: false do |builder|
      render("comments/comment_fields", f: builder)
    end
    link_to(name, '#', class: "add_comment", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
