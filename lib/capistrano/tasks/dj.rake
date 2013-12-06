load File.expand_path("../set_rails_env.rake", __FILE__)

namespace :dj do

  desc "Start delayed_job process"
  task :start => [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute "script/delayed_job start"
        end
      end
    end
  end

  desc "Stop delayed_job process"
  task :start => [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute "script/delayed_job stop"
        end
      end
    end
  end

  desc "Restart delayed_job process"
  task :start => [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute "script/delayed_job stop"
        end
        with rails_env: fetch(:rails_env) do
          execute "script/delayed_job start"
        end
      end
    end
  end

  after "deploy:start", "dj:start"
  after "deploy:stop", "dj:stop"
  after "deploy:restart", "dj:restart"
end

namespace :load do
  task :defaults do
  end
end