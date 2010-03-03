# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :set_uid

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  def set_uid
    if request.env["HTTP_USER_AGENT"].match(/(APUID=\S*)/).nil?
      session[:uid] = "APUID=" + UUID.create.to_s.gsub(/-/, '')
      session[:new_uid] = true
    else
      session[:uid] = $~[1]
    end
  end
end
 