namespace :tomcat do

  desc "start tomcat"
  task :start do
    on roles(:app) do
      within fetch(:tomcat_ctrl) do
          execute :sh, "#{fetch(:tomcat_script)} start"
      end
    end
  end

  desc "stop tomcat"
  task :stop do
    on roles(:app) do
      within fetch(:tomcat_ctrl) do
          execute :sh, "#{fetch(:tomcat_script)} stop"
      end
    end
  end

  desc "stop and start tomcat"
  task :restart do
    on roles(:app) do
      within fetch(:tomcat_ctrl) do
          execute :sh, "#{fetch(:tomcat_script)} stop"
      end
      within fetch(:tomcat_ctrl) do
          execute :sh, "#{fetch(:tomcat_script)} start"
      end
    end
  end

  desc "tail :tomcat_home/logs/*.log and logs/catalina.out"
  task :tail do
    on roles(:app) do
      execute :tail, "-f #{fetch(:tomcat_home)}/logs/*.log #{fetch(:tomcat_home)}/logs/catalina.out"
    end
  end


  after "deploy:finished", "tomcat:restart"

end

namespace :load do
  task :defaults do
    set :tomcat_home, "/opt/tomcat6"
    set :tomcat_ctrl, "/etc/init.d"
    set :tomcat_script, "tomcat6"
  end
end