class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }
  # before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_user_language

  def admin?
    if !current_user.admin
      flash[:alert] = "Unauthorized access"
      redirect_to root_path
    end
  end

  private

  def set_user_language
    I18n.locale = current_user.language if signed_in?
  end

end
