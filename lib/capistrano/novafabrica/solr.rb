require 'capistrano/novafabrica/helper'

configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

configuration.load do
  
  after "deploy:update_code", "solr:update"  
  
  namespace :solr do

  desc "Solr Reindex"
  task :reindex, :role => :web do
    run "cd #{current_path}; bundle exec rake RAILS_ENV=#{rails_env} maharam:reindex"
  end
  
end
  
end