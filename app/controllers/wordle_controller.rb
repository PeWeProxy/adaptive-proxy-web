#coding: utf-8
#
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
      unless r[:keywords].nil?
        r[:keywords].split(',').each do |item|
          word = item.split.join(' ')
          keywords[word] = keywords[word] + 1 unless word == ''
        end
      end
    end

    keywords_parameter=""
    keywords.each do |key,value|
      keywords_parameter << key + ":" + value.to_s + "\n"
    end

    render :inline => keywords_parameter and return if params[:raw]

    wordle_params = {'wordcounts' => keywords_parameter}

    response = Net::HTTP.post_form(URI.parse('http://www.wordle.net/compose'), wordle_params)
    render :inline => response.body
  end

end
