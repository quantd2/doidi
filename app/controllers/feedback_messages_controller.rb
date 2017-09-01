class FeedbackMessagesController < ApplicationController
  def new
    @feedback_message = FeedbackMessage.new
    if current_user
      @feedback_message.name = current_user.name
      @feedback_message.email = current_user.email
    end
  end

  def create
    if params[:email].present?
      redirect_to root_url, :notice => "Lời nhắn của bạn bị hê thống spam phát hiện vì bạn để trường email trống. Vui lòng thử lại với trường email hợp lệ."
    else
      @feedback_message = FeedbackMessage.new(feedback_params)
      if @feedback_message.save
        redirect_to root_url, notice: t('feedback.create.thanks')
      else
        render :new
      end
    end
  end

  private

  def feedback_params
    params.require(:feedback_message).permit(:email, :name, :content)
  end
end
