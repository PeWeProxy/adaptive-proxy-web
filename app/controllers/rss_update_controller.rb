require 'rss/maker'

class RssUpdateController < ApplicationController
	
  skip_before_filter :verify_authenticity_token
	
	def create
    source = "./public/news.xml"
    content = ""
    open(source) do |s| content = s.read end
    rss = RSS::Parser.parse(content, false)

    version = "2.0"
    destination = "./public/news.xml"
    
    content = RSS::Maker.make(version) do |m|
      m.channel.title = "Peweproxy RSS Feed"
      m.channel.link = "http://peweproxy-staging.fiit.stuba.sk"
      m.channel.description = "Here are all new peweproxy stable versions"
      m.items.do_sort = true
      
      $i = 0;
      exist = 0;
      
      while rss != nil and $i < rss.items.size do
        if exist == 0 and rss.items[$i].title == params[:tag]
          exist = 1
        end
        i = m.items.new_item
        i.title = rss.items[$i].title
        i.link = rss.items[$i].link
        i.date = rss.items[$i].date
        i.description = rss.items[$i].description
        $i +=1;
      end
      
      if exist == 0
        i = m.items.new_item
        i.title = params[:tag]
        i.link = "http://peweproxy-staging.fiit.stuba.sk"
        i.date = Time.now
        i.description = params[:tagmsg]
      end
      
    end
    
    File.open(destination,"w") do |f|
      f.write(content) 
    end
  
    render :nothing => true
  end
   
end