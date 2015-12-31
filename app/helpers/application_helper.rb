module ApplicationHelper
  def timeago(time)
    content_tag(:span, time.iso8601, title: time.iso8601, class: 'timeago')
  end
  
  def signed_in?
    if !current_user.nil?
      if current_user.email
        return true
      end
    end
    return false
  end
  
  def current_user
    @current_user
  end
  
  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true)
    return markdown.render(text).html_safe
  end
end
