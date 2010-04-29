class WebimpController < ApplicationController
  
  def feedback
    return unless params[:checksum] and params[:value]
    
    wi_feedback = WiFeedback.by_checksum(params[:checksum], session[:apuid]).first
      
    if wi_feedback.nil? then
      id = Page.find_by_checksum(params[:checksum])
      wi_feedback = WiFeedback.new(id, session[:apuid])
    end
      
    # if :value == 0, no feedback was sent  
    if (params[:value].to_i > 0) then
      wi_feedback.increase_positive_feedback
    end
    if (params[:value].to_i < 0) then
      wi_feedback.increase_negative_feedback
    end
    
    wi_feedback.save
       
    render :nothing => true
  end 
  
end