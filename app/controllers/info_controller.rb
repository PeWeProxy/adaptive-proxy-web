class InfoController < ApplicationController
  def index
  end

  def show
    @uid = session[:uid]
    render :action => params[:page]
  end
end
