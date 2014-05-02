module ApplicationHelper

  def round(param)

    number_with_precision(param, precision: 1)

  end

  def check_if_allowed_to_see_link
    if current_user.nil? or !current_user.admin
      return false
    end
    return true
  end
end
