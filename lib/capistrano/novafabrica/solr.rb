require 'capistrano/novafabrica/helper'

configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

configuration.load do
  
  after "deploy:update_code", "solr:update"  
  
  namespace :solr do
    
  desc "Solr Update"
  task :update, :role => :web do
    run "cp #{latest_release}/lib/schema.xml /opt/maharam-solr/conf/"
    run "cp #{latest_release}/lib/solrconfig.xml /opt/maharam-solr/conf/"
  end

  desc "Solr Reindex"
  task :reindex, :role => :web do
    run "cd #{current_path}; bundle exec RAILS_ENV=#{rails_env} sunspot:reindex"
  end
  
end
  
end