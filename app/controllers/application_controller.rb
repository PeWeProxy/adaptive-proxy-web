# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :set_uid

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  def set_uid
    uid = get_uid_from_user_agent
    if uid
      session[:uid] = uid
      session[:apuid] = uid.split('=')[1]
    elsif session[:uid].nil?
      session[:uid] = generate_uid
    end

    if uid
      session[:has_uid] = true
    else
      session[:has_uid] = false
    end
  end

  def generate_uid
      "APUID=#{UUID.create.to_s.gsub(/-/, '')}"
  end

  def get_uid_from_user_agent
    if request.env["HTTP_USER_AGENT"].match(/(APUID=\S*)/)
      $1
    else
      nil
    end
  end
end
 
