class LogsController < ApplicationController
  CouchPotato::Config.database_name = 'proxy'

  before_filter :retrieve_logs

  def list
    @uid = session[:apuid]
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
    return "no keywords available" if result == ""
    return result
  end

  private
  def retrieve_logs
    #@logs = AccessLog.paginate(:conditions => ['userid like ?', session[:apuid]], :page => params[:page], :order => 'timestamp DESC', :include => 'page')
    @logs = CouchPotato.database.view AccessLog.all_by_user(:key => session[:apuid])

    @logs.each_with_index do |log, index|
      pages = CouchPotato.database.view Page.by_id(:key => log.page_id)
      if pages.length == 0
        log.keywords = "no keywords found"
        next
      end
      log.keywords = parse_keywords(pages[0].pages_terms.to_json)

    end
  end
end