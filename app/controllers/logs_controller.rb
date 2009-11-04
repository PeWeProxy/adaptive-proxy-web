class LogsController < ApplicationController
  before_filter :retrieve_logs

  def list
    @uid = session[:uid]
  end

  def delete
    @logs[params[:id].to_i].destroy
    redirect_to :action => :list
  end

  private
  def retrieve_logs
    @logs = AccessLog.paginate_by_userid @uid, :page => params[:page], :order => 'timestamp DESC'
  end
end
