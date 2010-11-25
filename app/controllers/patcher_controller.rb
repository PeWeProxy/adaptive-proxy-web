class PatcherController < ApplicationController
  def download
    @uid = session[:uid]
    # redirect_to :action => :download_browser_patcher unless session[:has_uid]
  end

  def store
    if (params[:identifier].empty?)
      flash[:error] = "you must choose an identifier!"
    elsif (!StoredApuid.find_by_identifier(params[:identifier]).nil?)
      flash[:error] = "sorry, this identifier is already taken"
    else
      StoredApuid.create(:identifier => params[:identifier], :uid => session[:uid], :valid_until => Date.today + 30)
    end
    redirect_to :back
  end

  def retrieve_uid_ever_cookie
    @back = params[:back]
    if(params[:identifier].empty?)
      flash[:error] = "missing identifier for retrieval"
      redirect_to :back and return
    end
    retrievedApuid = StoredApuid.find_by_identifier(params[:identifier])
    if(retrievedApuid.nil?)
      flash[:error] = "Did not find an APUID with identifier \'#{params[:identifier]}\' in the database."
      redirect_to :back and return;
    end

    @uid = retrievedApuid.uid.split('=')[1]
    @back = "/"
    render('set_cookie/cookie_restore')

    retrievedApuid.destroy unless params[:leave_apuid] == "1"
  end

  def retrieve
    if(params[:identifier].empty?)
      flash[:error] = "missing identifier for retrieval"
      redirect_to :back and return
    end
    retrievedApuid = StoredApuid.find_by_identifier(params[:identifier])
    if(retrievedApuid.nil?)
      flash[:error] = "Did not find an APUID with identifier \'#{params[:identifier]}\' in the database."
      redirect_to :back and return
    end
    if (params[:commit] == PATCHER_BUTTON_LABEL)
      redirect_to :action => "download_browser_patcher", :uid => retrievedApuid.uid
    else
      redirect_to :action => "download_ff_extension", :uid => retrievedApuid.uid
    end

    retrievedApuid.destroy unless params[:leave_apuid] == "1"

  end
end
