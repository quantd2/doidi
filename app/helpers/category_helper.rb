module CategoryHelper
  def nested_categories(category)
    category.map do |category, categories|
      render(category) + content_tag(:div, nested_categories(categories), :class => "nested_categories")
    end.join.html_safe
  end
end
