class KeywordsController < ApplicationController

  def load
    @keywords = Page.find_by_checksum(params[:checksum]) if params[:checksum]
    render :layout => false
  end

end
