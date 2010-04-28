require 'cgi'

class RecommendationsController < ApplicationController
  def show
    recommendation = Recommendation.find_by_id(params[:id])
    recommendation.clicked = true
    recommendation.clicked_at = Time.new

    recommendation.save

    redirect_to recommendation.recommended_url
  end

  def group
    group = RecommendationGroup.find_by_id(params[:id])
    group.clicked = true
    group.clicked_at = Time.new
    group.clicked_query = CGI::unescape(params[:q])

    group.save

    redirect_to("http://www.google.com/search?q=" + CGI::escape(params[:q]) + "#dontrecommend")
  end

  def negative
    group = RecommendationGroup.find_by_id(params[:id])
    group.negative = true
    group.negative_at = Time.new
    group.clicked_query = CGI::unescape(params[:q])

    group.save

    redirect_to :back
  end
end
