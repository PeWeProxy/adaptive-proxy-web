class BrokenPageController < ApplicationController

	def reporter
		#if (request.env['HTTP_VIA'] =~ /AdaptiveProxy/) == nil
    #  flash[:error] = "Only proxy users are allowed to report broken pages"
		#end
	end
	
	def create
		if (params[:url].empty?)
      flash[:error] = "URL must not be empty."
		#elsif (request.env['HTTP_VIA'] =~ /AdaptiveProxy/) == nil
    #  flash[:error] = "Only proxy users are allowed to report broken pages"
    elsif (params[:url] =~ /(http:\/\/)?[a-z0-9]+([-.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?/) == nil
			flash[:error] = "Wrong format of url."
		elsif BrokenPages.find_by_url(params[:url]) != nil
			flash[:error] = "This page already is in our database."
    else
      BrokenPages.create(:url => params[:url], :uid => session[:apuid], :timestamp => Time.now)
			flash[:notice] = "The page was successfully added to our database. Thank you."
    end
    redirect_to :back
  end

end
