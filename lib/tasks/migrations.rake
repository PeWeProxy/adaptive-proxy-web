desc "Perform unperformed CouchDB migrations"

namespace :couch do
  task :migrate do
    Dir.glob("db/couch/*") do |migration|
      puts
      puts "== running #{migration}"
      `ruby "#{migration}"`
    end
  end
end