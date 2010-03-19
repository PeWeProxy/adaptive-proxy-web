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
    @proxy_pac = "http://peweproxy.fiit.stuba.sk/proxy.pac"
  end

  def projects
  end

  def technologies
    @repositories_url = "http://relax.fiit.stuba.sk/gitweb"
  end
end
