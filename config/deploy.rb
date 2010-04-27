set :application, "proxy"
set :repository,  "gitosis@relax.fiit.stuba.sk:adaptive-proxy-web.git"
set :deploy_to, "/var/rails/#{application}"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server "peweproxy.fiit.stuba.sk", :app, :web, :db, :primary => true
set :user, "peweproxy"
set :use_sudo, false


namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :deploy do
  task "start", :roles => :app do
    passenger.restart
  end

  desc "Symlink shared"
  task :symlink_shared do
    run "ln -nfs #{shared_path} #{release_path}/shared"
  end

  task "restart", :roles => :app do
    passenger.restart
  end
end

task :disable_web, :roles => :web do
  on_rollback { delete "#{shared_path}/system/maintenance.html" }
  
  maintenance = render("./app/views/layouts/maintenance.rhtml", 
                       :deadline => ENV['UNTIL'],
                       :reason => ENV['REASON'])
                       
  put maintenance, "#{shared_path}/system/maintenance.html", 
                   :mode => 0644
end


after 'deploy:update_code', 'deploy:symlink_shared'
after 'deploy', 'deploy:cleanup'

