module ApplicationHelper
  def application_name
    Rails.application.class.parent_name.underscore.humanize
  end
end

