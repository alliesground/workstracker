module ApplicationHelper
  def flash_class(level)
    case level
    when 'success' then "ui positive message"
    when 'error' then "ui error message"
    when 'notice' then "ui info message"
    when 'alert' then "ui warning message"
    end
  end
end
