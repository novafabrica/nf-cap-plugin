require 'capistrano/novafabrica/helper'

configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

configuration.load do
  
  _cset(:rails_root)      { abort 'Please specify rails root with "#{File.dirname(__FILE__)}/.."'}

  before "deploy:cold", "db:create_database_file"
  #after "deploy:cold", "db:create_database"
  
  namespace :db do
    desc "create mysql db"
    task :create_database do
      run "cd #{current_release}; bundle exec rake RAILS_ENV=#{rails_env} db:create"
    end

    desc "After updating code we need to populate a new database.yml"
    task :create_database_file, :roles => :app do
      require "yaml"
      run "mkdir -p  #{shared_path}/config/"
      buffer = YAML::load_file(rails_root + 'config/database.yml')
      # get ride of uneeded configurations
      buffer.delete('test')
      buffer.delete('development')
      buffer.delete('cucumber')

      # Populate production element
      buffer["#{rails_env}"]['username'] = "deploy"
      buffer["#{rails_env}"]['password'] = Capistrano::CLI.ui.ask("Enter MySQL database password: ")

      put YAML::dump(buffer), "#{shared_path}/config/database.yml", :mode => 0664
    end

  end

end
