module ApplicationHelper
  def nav_link(text, path)
    active_class = current_page?(path) ? :active : ''

    content_tag(:li, class: active_class) do
      link_to text, path
    end
    
  end
end
