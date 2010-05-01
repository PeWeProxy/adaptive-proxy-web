class MaintenanceController < ApplicationController

  MAX_LENGTH = 30

  def keywords
    pages = Page.all

    pages.each do |page|
      unless page.keywords.nil?
        page.keywords = page.keywords.split(',').reject do |kw|
          kw.length > MAX_LENGTH or kw =~ /http:\/\// or kw =~ /www\./ or kw =~ /:\/\//
        end.inject{ |memo, val| "#{memo},#{val}"}

        page.save!
      end
    end

    render :inline => 'Done.'
  end
end
