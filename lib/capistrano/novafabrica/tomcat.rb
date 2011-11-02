require 'capistrano/novafabrica/helper'

configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

configuration.load do
  
  after "deploy:update_code", "tomcat:restart"
  
  _cset :tomcat_home, "/opt/tomcat6/"
  _cset :tomcat_ctrl, "/etc/init.d/tomcat6"

  namespace :tomcat do

    desc "start tomcat"
    task :start do
      "#{tomcat_ctrl} start"
    end

    desc "stop tomcat"
    task :stop do
      "#{tomcat_ctrl} stop"
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

  end

end
