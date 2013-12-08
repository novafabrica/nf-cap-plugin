 after "deploy:restart", "unicorn:restart"

  _cset :unicorn_ctrl, "/etc/init.d/unicorn"

  namespace :unicorn do

    desc "start unicorn"
    task :start do
      run "#{unicorn_ctrl} start"
    end

    desc "stop unicorn"
    task :stop do
      run "#{unicorn_ctrl} stop"
    end

    desc "restart unicorn"
    task :restart do
      run "#{unicorn_ctrl} restart"
    end

    desc "tail :current_path/log/unicorn.stderr.log"
    task :tail do
      stream "tail -f #{current_path}/log/unicorn.stderr.log"
    end

  end

end