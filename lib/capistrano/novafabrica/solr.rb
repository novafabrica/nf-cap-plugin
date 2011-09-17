require 'capistrano/novafabrica/helper'

configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

configuration.load do
  
  after "deploy:update_code", "deploy:solr_config"  
  
  desc "Solr Update"
  task :solr_config, :role => :web do
    run "cp #{latest_release}/lib/schema.xml /opt/maharam-solr/conf/"
    run "cp #{latest_release}/lib/solrconfig.xml /opt/maharam-solr/conf/"
  end

  desc "Solr Reindex"
  task :solr_reindex, :role => :web do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} rake sunspot:reindex"
  end
  
end