class WelcomeController < ApplicationController
  # before_action :authenticate_user!

  def index
    text_preprocessed = strip_accent(filtering_params[:query])
    @items = Item.text_search(text_preprocessed).page(params[:page])
    @items = @items.filter(filtering_params.reject { |k,v| k == "query" }).page params[:page]
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

  private

  def filtering_params
    if params[:filtering]
      return params.require(:filtering).permit(:query, :location, :category)
    else
      params.merge(filtering: {query: "", location: "", category: ""}).require(:filtering).permit(:query, :location, :category)
    end
  end
end
