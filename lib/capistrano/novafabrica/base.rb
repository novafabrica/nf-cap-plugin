require 'capistrano/novafabrica/helper'
require 'capistrano/novafabrica/database'

configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

configuration.load do

  after "deploy:update_code", "deploy:create_symlinks"
  after "deploy:update_code", "deploy:cleanup"

  # Configuration
  #

  # Multistage
  require 'capistrano/ext/multistage'
  _cset(:default_stage) { 'staging' }

  # User details
  _cset :user,          'deploy'
  # Application details
  _cset(:runner)        { user }
  _cset :use_sudo,      false

  # SCM settings
  _cset :scm,           'git'
  set(:repository)      { "git@github.com:novafabrica/#{app_name}.git" }
  _cset :branch,        'master'
  _cset :deploy_via,    'remote_cache'
  _cset(:symlinks)      { Hash.new }

  # Git settings for Capistrano
  default_run_options[:pty]     = true # needed for git password prompts
  ssh_options[:forward_agent]   = true # use the keys for the person running the cap command to check out the app

  # Deploy tasks for Passenger
  namespace :deploy do

    desc "Restarting mod_rails with restart.txt"
    task :restart, :roles => :app, :except => { :no_release => true } do
      run "touch #{current_path}/tmp/restart.txt"
    end


    desc "Create symlinks from the latest release to the shared directory"
    task :create_symlinks do

      run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"

      symlinks.each do |type, dir|
        run "mkdir -p  #{shared_path}/public/#{type}/#{dir}"
        run "rm -rf #{latest_release}/public/#{type}/#{dir}"
        run "ln -nfs #{shared_path}/public/#{type}/#{dir} #{latest_release}/public/#{type}/#{dir}"
      end

    end

  end

end
