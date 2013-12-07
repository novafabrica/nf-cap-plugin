namespace :tomcat do

  desc "start tomcat"
  task :start do
    on roles(:app) do
      within tomcat_ctrl do
          execute :sh, "#{fetch(:tomcat_script)} start"
      end
    end
  end

  desc "stop tomcat"
  task :stop do
    on roles(:app) do
      within tomcat_ctrl do
          execute :sh, "#{fetch(:tomcat_script)} stop"
      end
    end
  end

  desc "stop and start tomcat"
  task :restart do
    tomcat.stop
    tomcat.start
  end

  desc "tail :tomcat_home/logs/*.log and logs/catalina.out"
  task :tail do
    stream "tail -f #{tomcat_home}/logs/*.log #{tomcat_home}/logs/catalina.out"
  end


  after "deploy:finished", "tomcat:restart"

end

namespace :load do
  task :defaults do
    set :tomcat_home, "/opt/tomcat6/"
    set :tomcat_ctrl, "/etc/init.d"
    set :tomcat_script
  end
end