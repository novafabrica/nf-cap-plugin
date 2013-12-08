
namespace :db do

  desc "After updating code we need to populate a new database.yml"
  task :create_database_file do
    require "yaml"
    on roles(:web) do
      within shared_path do
        execute :mkdir, "-p config"
        buffer = YAML::load_file(rails_root + 'config/database.yml')
        # get ride of uneeded configurations
        buffer.delete('test')
        buffer.delete('development')
        buffer.delete('cucumber')

        # Populate production element
        buffer["#{rails_env}"]['username'] = "deploy"
        puts "Enter MySQL database password: "
        input = STDIN.gets.chomp
        buffer["#{rails_env}"]['password'] = input

        put YAML::dump(buffer), "#{shared_path}/config/databases.yml", :mode => 0664
      end
    end

  end

  before "deploy:cold", "db:create_database_file"

end