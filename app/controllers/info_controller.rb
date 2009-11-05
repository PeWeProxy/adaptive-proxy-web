class InfoController < ApplicationController

  def user_agent
    @uid = session[:uid]
  end
end
