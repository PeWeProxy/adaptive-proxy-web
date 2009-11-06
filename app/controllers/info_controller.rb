class InfoController < ApplicationController

  def index
    
  end
  def user_agent
    @uid = session[:uid]
  end

  def settings
    @uid = session[:uid]    
  end
end
