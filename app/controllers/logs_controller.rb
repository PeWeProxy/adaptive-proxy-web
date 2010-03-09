class LogsController < ApplicationController
  before_filter :retrieve_logs

  def list
    @uid = session[:apuid]
  end

  def delete
    @logs[params[:id].to_i].destroy
    redirect_to :action => :list
  end

  private
  def retrieve_logs
    @logs = AccessLog.paginate_by_userid(session[:apuid], :page => params[:page], :order => 'timestamp DESC', :include => 'page')
  end
end
