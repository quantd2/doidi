class WelcomeController < ApplicationController
  # before_action :authenticate_user!

  def index
    @items = Item.all.page params[:page]
    # text_preprocessed = strip_accent(params[:query])
    # @items = Item.text_search(text_preprocessed).includes(:options).page(params[:page])
  end

  def about
  end

  private

  def strip_accent query
    if query
      result = query.gsub(/[àáạảãâầấậẩẫăằắặẳẵ]/, 'a')
      result = query.gsub(/[èéẹẻẽêềếệểễ]/, 'e')
      result = query.gsub(/[ìíịỉĩ]/, 'i')
      result = query.gsub(/[òóọỏõôồốộổỗơờớợởỡ]/, 'o')
      result = query.gsub(/[ùúụủũưừứựửữ]/, 'u')
      result = query.gsub(/[ỳýỵỷỹ]/, 'y')
      result = query.gsub(/[đ]/, 'd')
      result = query.gsub(/[ÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴ]/, 'A')
      result = query.gsub(/[ÈÉẸẺẼÊỀẾỆỂỄ]/, 'E')
      result = query.gsub(/[ÌÍỊỈĨ]/, 'I')
      result = query.gsub(/[ÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠ]/, 'O')
      result = query.gsub(/[ÙÚỤỦŨƯỪỨỰỬỮ]/, 'U')
      result = query.gsub(/[ỲÝỴỶỸ]/, 'Y')
      result = query.gsub(/[Đ]/, 'D')
    else
      ""
    end
  end
end
