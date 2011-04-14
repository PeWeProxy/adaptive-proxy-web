class LogsController < ApplicationController
  CouchPotato::Config.database_name = 'proxy'

  LOGS_PER_PAGE = 2

  def list
    @uid = session[:apuid]
    
    @page = 0 if @page.nil?
    @page = params[:page].to_i unless params[:page].nil?

    @previous_pages_logs_ids = Array.new if @previous_pages_logs_ids.nil?
    @previous_pages_logs_ids = params[:previous_pages] unless params[:previous_pages].nil?

    fetch_logs
    
    if @logs.length > LOGS_PER_PAGE
      @next_page_log_id = @logs.delete_at(@logs.length - 1)._id
    else
      @next_page_log_id = nil
    end

    @previous_pages_logs_ids << @logs[0]._id if @logs.length > 0
  end

  def fetch_logs
    @logs = CouchPotato.database.view AccessLog.all_by_user(:key => session[:apuid], :startkey_docid => params[:next_startkey], :limit => LOGS_PER_PAGE + 1)
    @logs.each_with_index do |log, index|
      pages = CouchPotato.database.view Page.by_id(:key => log.page_id)
      if pages.length == 0
        next
      end
      log.keywords = parse_keywords(pages[0].pages_terms.to_json)
      log.url = pages[0].url
    end
  end

  def delete_many
    if params[:for_deletion].nil?
      flash[:error] = "You haven't selected any log to be deleted, yet."
      flash[:error_sk] = "Nevybral si logy na zmazanie."
      redirect_to :action => :list
      return
    end

    params[:for_deletion].each do |doc_for_deletion|
      docs = CouchPotato.database.view AccessLog.by_id(:key => doc_for_deletion)
      docs.each do |doc|
        CouchPotato.database.destroy_document doc
      end
    end

    flash[:notice] = "Items successfuly deleted."
    flash[:notice_sk] = "Hotovo."
    redirect_to :action => :list
  end

  private
  def parse_keywords(string)
    result = ""
    string.scan(/"label":"[^,]+"/){|a| result << a.gsub(/"label":|"/, '') + ", "} #magic :)
    return result
  end

end