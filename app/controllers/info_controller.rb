class InfoController < ApplicationController

  def index
  end

  def user_agent
    @uid = session[:uid]
  end

  def settings
    @uid = session[:uid]
    @proxy_pac = "http://peweproxy.fiit.stuba.sk/proxy.pac"
    @proxy_url = "http://peweproxy.fiit.stuba.sk:9666"
  end

  def privacy
  end

  def projects
  end
end
