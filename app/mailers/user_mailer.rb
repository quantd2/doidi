class UserMailer < ActionMailer::Base
  def feedback(message)
    @message = message
    mail to: "feedback@doidi.com",
         from: "admin@doidi.com",
         subject: "doidi Feedback from #{@message.name}"
  end

  def comment_notification(comment, user)
    @comment = comment
    @user = user
    mail to: @user.email,
         from: "dinhquan.tran@gmail.com",
         subject: "Trả lời bình luận từ doidi"
  end
end
