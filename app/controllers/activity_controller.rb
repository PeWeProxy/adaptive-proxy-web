class ActivityController < ApplicationController
  def update
    return unless params[:checksum] and params[:period]
    access_log = AccessLog.by_checksum(params[:checksum], session[:uid]).first

    if not access_log.nil? then
      access_log.increase_time_on_page params[:period]
      access_log.save
    end

    render :nothing => true
  end
end
