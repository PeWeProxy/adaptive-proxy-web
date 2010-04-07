class ActivityController < ApplicationController
  def update
    return unless params[:checksum] and params[:period] and params[:scrolls] and params[:copies]
    access_log = AccessLog.by_checksum(params[:checksum], session[:apuid]).first

    if not access_log.nil? then
      access_log.increase_time_on_page params[:period]
      access_log.increase_scroll_count params[:scrolls]
      access_log.increase_copy_count params[:copies]
      access_log.save
    end

    render :nothing => true
  end
end
