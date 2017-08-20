module ApplicationHelper
  def full_title(page_title)
    base_title = "Đổi Đi"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
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
    fields = simple_form_for Comment.new(parent_id: id), validate: true, remote: true do |builder|
      render("comments/comment_fields", f: builder)
    end
    link_to(name, '#', class: "add_comment", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
