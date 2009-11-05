class InfoController < ApplicationController

  def user_agent
    @relative_url_root = relative_url_root
    @uid = session[:uid]
  end
end
