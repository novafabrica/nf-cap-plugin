require 'capistrano/novafabrica/helper'

configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

configuration.load do
  
  after "deploy:update_code", "unicorn:restart"
  
  _cset :unicorn_ctrl, "/etc/init.d/unicorn"

  namespace :unicorn do

    desc "start unicorn"
    task :start do
      "#{unicorn_ctrl} start"
    end

    desc "stop unicorn"
    task :stop do
      "#{unicorn_ctrl} stop"
    end

    desc "restart unicorn"
    task :restart do
      "#{unicorn_ctrl} restart"
    end

    desc "tail :current_path/log/unicorn.stderr.log"
    task :tail do
      stream "tail -f #{current_path}/log/unicorn.stderr.log"
    end

  end

end