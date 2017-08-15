module ItemHelper
  def comment_poll_name_display?
    request.path_info.include?("user") and request.path_info.include?("comments")
  end
end
