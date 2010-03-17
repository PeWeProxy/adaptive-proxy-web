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

after 'deploy:update_code', 'deploy:symlink_shared'

