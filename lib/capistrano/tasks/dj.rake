namespace :dj do

  # In Rails 4 the delayed_job init script is moved into the bin directory.
  def delayed_job_command
    if test "[ -e #{current_path}/bin/delayed_job ]"
      "bin/delayed_job"
    else
      "script/delayed_job"
    end
  end

  desc "Start delayed_job process"
  task :start do
    on roles(:app) do
      within release_path do
        with rails_env: (fetch(:rails_env) || fetch(:stage)) do
          execute :ruby, "#{delayed_job_command} stop"
        end
      end
    end
  end

  desc "Stop delayed_job process"
  task :stop do
    on roles(:app) do
      within release_path do
        with rails_env: (fetch(:rails_env) || fetch(:stage)) do
          execute :ruby, "#{delayed_job_command} start"
        end
      end
    end
  end

  desc "Restart delayed_job process"
  task :restart do
    on roles(:app) do
      within release_path do
        with rails_env: (fetch(:rails_env) || fetch(:stage)) do
          execute :ruby, "#{delayed_job_command} restart"
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