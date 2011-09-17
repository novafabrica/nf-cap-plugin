require 'capistrano/novafabrica/helper'

configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

configuration.load do

  after "deploy:start", "delayed_job:start"
  after "deploy:stop", "delayed_job:stop"
  after "deploy:restart", "delayed_job:restart"

  namespace :delayed_job do
    desc "Start delayed_job process"
    task :start, :roles => :app do
      run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job start"
    end

    desc "Stop delayed_job process"
    task :stop, :roles => :app do
      run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job stop"
    end

    desc "Restart delayed_job process"
    task :restart, :roles => :app do
      run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job stop"
      run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job start"
    end
  end

end
