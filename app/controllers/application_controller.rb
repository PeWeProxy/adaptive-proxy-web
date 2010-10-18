# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :set_uid, :set_locale

  def set_locale
    I18n.locale = params[:locale] || request.preferred_language_from(I18n.available_locales)
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  def set_uid
    agent_uid = get_uid_from_user_agent
    cookie_uid = get_uid_from_cookie
    if agent_uid
      session[:uid] = agent_uid
      session[:apuid] = agent_uid.split('=')[1]
    elsif cookie_uid
      session[:uid] = "APUID=" + cookie_uid
      session[:apuid] = cookie_uid
    elsif session[:uid].nil?
      session[:uid] = generate_uid
      session[:apuid] = session[:uid].split('=')[1]
    end

    if agent_uid || cookie_uid
      session[:has_uid] = true
    else
      session[:has_uid] = false
    end
  end

  def generate_uid
      "APUID=#{UUID.create.to_s.gsub(/-/, '')}"
  end

  def get_uid_from_user_agent
    if request.env["HTTP_USER_AGENT"].match(/(APUID=[0-9a-zA-Z]*)/)
      $1
    else
      nil
    end
  end

  def get_uid_from_cookie
    #TODO: shall we check something?
    return request.cookies["__peweproxy_uid"]
  end
end
 
