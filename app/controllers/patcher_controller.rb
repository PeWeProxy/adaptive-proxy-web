class PatcherController < ApplicationController
  @@uid_label = "APUID="
  @@uid = "$replace_this$"
  PATCHER_BUTTON_LABEL = "download browser patcher"
  PATCHER_FF_EXT_LABEL = "download firefox extension only"

  def index
    @uid = session[:uid]
    @patcher_button_label = PATCHER_BUTTON_LABEL
    @patcher_ff_ext_label = PATCHER_FF_EXT_LABEL
  end

  def store
    if (params[:identifier].empty?)
      flash[:error] = "you must choose an identifier!"
    elsif (!StoredApuid.find_by_identifier(params[:identifier]).nil?)
      flash[:error] = "sorry, this identifier is already taken"
    else
      StoredApuid.create(:identifier => params[:identifier], :uid => request.env["HTTP_USER_AGENT"].match(/APUID=(\S*)/)[1], :valid_until => Date.today + 30)
    end
    redirect_to :back
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

  def initialize
    @generator = Uuid.new
  end

  def download_browser_patcher
    download_a_file "browser_patcher", "jar", "uadef.txt", @@uid, @@uid_label, params[:uid]
  end

  def download_ff_extension
    download_a_file "ff_extension", "xpi", "defaults/preferences/defaults.js", "pref('general.useragent.extra.adaptiveproxy','#{@@uid}');", @@uid_label, params[:uid]
  end

  def download_a_file filename, extension, edit_path, string, uid_label, uid=nil
    uid ||= @generator.generate(:compact).to_s

    if (uid.index(uid_label).nil?)
      uid_to_print = uid_label + uid
    else
      uid_to_print = uid
    end

    path = "#{RAILS_ROOT}/templates"

    FileUtils.cp_r "#{path}/#{filename}", "#{path}/#{uid}"

    f = File.open("#{path}/#{uid}/#{edit_path}", "w")
    f.puts string.gsub('$replace_this$', uid_to_print)
    f.close

    Dir.chdir("#{path}/#{uid}/")
    `zip -0 -r #{RAILS_ROOT}/public/download/#{filename}-#{uid}.#{extension} .`
    redirect_to relative_url_root + "/download/#{filename}-#{uid}.#{extension}"
  end
end
