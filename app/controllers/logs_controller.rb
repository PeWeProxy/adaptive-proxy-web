class LogsController < ApplicationController
  CouchPotato::Config.database_name = 'proxy'

  LOGS_PER_PAGE = 3

  def list
    @logs = CouchPotato.database.view AccessLog.by_user_and_timestamp(:startkey => [session[:apuid], params[:start]], :startkey_docid => params[:start_id], :limit => LOGS_PER_PAGE + 1)

    last_log = @logs.pop
    @next_page_startkey = last_log.timestamp
    @next_page_startkey_docid = last_log.id
  end

  def delete_many
    if params[:for_deletion].nil?
      flash[:error] = "You haven't selected any log to be deleted, yet."
      flash[:error_sk] = "Nevybral si logy na zmazanie."
      redirect_to :action => :list
      return
    end

    params[:for_deletion].each do |doc_for_deletion|
      doc = CouchPotato.database.load_document(doc_for_deletion)
      log = AccessLog.new :id => doc.id, :_rev => doc.rev
      CouchPotato.database.destroy_document log
    end

    flash[:notice] = "Items successfuly deleted."
    flash[:notice_sk] = "Hotovo."
    redirect_to :action => :list
  end
end
