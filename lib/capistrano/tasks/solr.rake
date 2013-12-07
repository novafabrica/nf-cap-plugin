
namespace :solr do

  desc "Solr Reindex"
  task :reindex do
    on roles(:web) do
      within release_path do
        with rails_env: (fetch(:rails_env) || fetch(:stage)) do
          execute :rake, "sunspot:reindex"
        end
      end
    end
  end

end