namespace :unicorn do

  desc "start unicorn"
  task :start do
    on roles(:app) do
      within fetch(:unicorn_ctrl) do
          execute :sh, "#{fetch(:unicorn_script)} start"
      end
    end
  end

  desc "stop unicorn"
  task :stop do
    on roles(:app) do
      within fetch(:unicorn_ctrl) do
          execute :sh, "#{fetch(:unicorn_script)} stop"
      end
    end
  end

  desc "stop and start unicorn"
  task :restart do
    on roles(:app) do
      within fetch(:unicorn_ctrl) do
          execute :sh, "#{fetch(:unicorn_script)} restart"
      end
    end
  end

  desc "tail :tail :current_path/log/unicorn.stderr.log"
  task :tail do
    on roles(:app) do
      within release_path do
       execute :tail, "-f log/unicorn.stderr.log"
      end
    end
  end


  after "deploy:finished", "unicorn:restart"

end

namespace :load do
  task :defaults do
    set :unicorn_ctrl, "/etc/init.d"
    set :unicorn_script, "unicorn"
  end
end

