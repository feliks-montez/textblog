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
end
