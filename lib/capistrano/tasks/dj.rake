namespace :dj do

  desc "Start delayed_job process"
  task :start do
    on roles(:app) do
      within release_path do
        with rails_env: (fetch(:rails_env) || fetch(:stage)) do
          execute :ruby, "script/delayed_job stop"
        end
      end
    end
  end

  desc "Stop delayed_job process"
  task :stop do
    on roles(:app) do
      within release_path do
        with rails_env: (fetch(:rails_env) || fetch(:stage)) do
          execute :ruby, "script/delayed_job start"
        end
      end
    end
  end

  desc "Restart delayed_job process"
  task :restart do
    on roles(:app) do
      within release_path do
        with rails_env: (fetch(:rails_env) || fetch(:stage)) do
        if test "[ -f #{shared_path}/bin/delayed_job ]"
          execute :ruby, "bin/delayed_job stop"
        else
          execute :ruby, "script/delayed_job stop"
        end
        with rails_env: (fetch(:rails_env) || fetch(:stage)) do
          execute :ruby, "script/delayed_job start"
        end
      end
    end
  end

  after "deploy:finished", "dj:restart"
end

namespace :load do
  task :defaults do
  end
end