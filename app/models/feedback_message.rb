class FeedbackMessage < ApplicationRecord
  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  validates_presence_of :name, :email, :content

  after_commit :send_feedback, on: :create

  def send_feedback
    UserMailer.feedback(self).deliver_later
  end

end
