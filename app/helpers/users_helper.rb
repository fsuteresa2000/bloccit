module UsersHelper
  def user_performed_action?(user_action, action_string)
    if user_action.empty?
      render html: "#{@user.name} has not created any #{action_string.pluralize} yet.".html_safe
    else
      render html: "<h2>#{action_string.capitalize.pluralize}</h2> #{render user_action}".html_safe
    end
  end
end
