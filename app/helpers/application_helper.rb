# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def proxy_base_url
    url_for :controller => :info, :action => :index
  end
end
