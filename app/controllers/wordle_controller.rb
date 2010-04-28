require "uri"
require "net/http"

class WordleController < ApplicationController
  def index
    user_id = session[:apuid]
    if user_id.nil?
      flash[:error] = "Však Ty nemáš ani APUID, tak aké tagy by si chcel? :)"
      redirect_to :root and return
    end
    keywords = Hash.new(0)
    dataset = AccessLog.find_by_sql(["SELECT keywords FROM access_logs a inner join pages p on a.page_id = p.id where userid = ?",user_id])

    dataset.each do |r|
        r[:keywords].split(',').each do |item|
            keywords[item] = keywords[item] + 1 unless item.starts_with?('http://')
        end
    end

    keywords_parameter=""
    keywords.each do |key,value|
      keywords_parameter << key + ":" + value.to_s + "\n"             
    end

    wordle_params = {'wordcounts' => keywords_parameter}

    response = Net::HTTP.post_form(URI.parse('http://www.wordle.net/compose'), wordle_params)
    render :inline => response.body
  end

end