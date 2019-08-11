module ApplicationHelper
  def full_title(page_title = " ")
    default_title = "Eventsboard -Create Events to Socialize"
    if page_title.empty?
      default_title
    else
      "#{page_title} | #{default_title}"
    end
  end

  def time_format(event_date)
    event_date.strftime("%Y-%m-%d %H:%M")
  end

  def event_status(event)
    if event.end_date <= Date.today
      content_tag(:span, "", class: "past")
    else
      content_tag(:span, "", class: "upcoming")
    end
  end
end
