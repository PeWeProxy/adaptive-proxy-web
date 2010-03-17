class InfoController < ApplicationController

  def index
    
  end
  def user_agent
    @uid = session[:uid]
  end

  def settings
    @uid = session[:uid]    
  end

  def privacy
  end

  def projects
  end
end
