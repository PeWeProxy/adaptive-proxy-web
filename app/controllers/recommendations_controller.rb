class RecommendationsController < ApplicationController
  def show
    recommendation = Recommendation.find_by_id(params[:id])
    recommendation.clicked = true
    recommendation.clicked_at = Time.new

    recommendation.save

    redirect_to recommendation.recommended_url
  end
end
