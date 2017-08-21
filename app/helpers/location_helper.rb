module LocationHelper
  def nested_resources(resource)
    resource.map do |resource, resources|
      render(resource) + content_tag(:div, nested_resources(resources), :class => "nested_#{resource.class.table_name}")
    end.join.html_safe
  end
end
