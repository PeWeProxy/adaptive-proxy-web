#############################################################
#	Application
#############################################################

set :application, "proxy"
set :deploy_to, "/var/rails/#{application}"

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
set :use_sudo, false

#############################################################
#	Servers
#############################################################

set :user, "barla"
set :domain, "nimbus.fiit.stuba.sk"
server domain, :app, :web
role :db, domain, :primary => true

#############################################################
#	Subversion
#############################################################

set :repository,  "https://leela.fiit.stuba.sk/svn/proxy/proxy_user_reg/"
#set :svn_username, ""
#set :svn_password, ""
set :deploy_via, :export

#############################################################
# Passenger
#############################################################

namespace :passenger do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :deploy do
  %w(start restart).each { |name| task name, :roles => :app do passenger.restart end }
end
