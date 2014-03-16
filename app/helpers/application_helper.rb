module ApplicationHelper
  def nav_link(text, path, opts={})
    active_class = current_page?(path) ? :active : ''

    content_tag(:li, class: active_class) do
      link_to text, path, opts
    end

  end
end
