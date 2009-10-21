require 'uuid/uuid'
#require 'zip/zip'

#require 'archive/tar/minitar'




class PatcherController < ApplicationController
  @@uid_label = "APUID="
  @@uid = "$replace_this$"

  def initialize
    @generator = UUID.new
  end

  def download_browser_patcher
    download_a_file "browser_patcher","jar","uadef.txt", @@uid, @@uid_label
  end

  def download_ff_extension
    download_a_file "ff_extension","xpi","defaults/preferences/defaults.js", "pref('general.useragent.extra.adaptiveproxy','#{@@uid}');", @@uid_label, params[:uid]
  end

  def download_a_file filename, extension, edit_path, string, uid_label, uid=nil
    uid ||= @generator.generate(:compact).to_s
    
    if(uid.index(uid_label).nil?)
        uid_to_print = uid_label + uid
    else
        uid_to_print = uid
    end

    path = "#{RAILS_ROOT}/templates"

    FileUtils.cp_r "#{path}/#{filename}", "#{path}/#{uid}"

    f = File.open("#{path}/#{uid}/#{edit_path}" , "w")
    f.puts string.gsub('$replace_this$', uid_to_print)
    f.close

    Dir.chdir("#{path}/#{uid}/")
    `zip -0 -r #{RAILS_ROOT}/public/download/#{filename}-#{uid}.#{extension} .`
    redirect_to relative_url_root + "/download/#{filename}-#{uid}.#{extension}"
  end
end
