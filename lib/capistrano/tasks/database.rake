
#  namespace :deploy do
#   namespace :check do
#     task :linked_files => 'config/databases.yml'
#   end
# end


# remote_file 'config/databases.yml' => 'tmp/databases.yml', roles: :app
# require "yaml"
# `mkdir -p config`
# buffer = YAML::load_file('config/database.yml')
# # get ride of uneeded configurations
# buffer.delete('test')
# buffer.delete('development')
# buffer.delete('cucumber')

# # Populate production element
# buffer["#{rails_env}"]['username'] = "deploy"
# puts "Enter MySQL database password: "
# input = STDIN.gets.chomp
# buffer["#{rails_env}"]['password'] = input

# put YAML::dump(buffer), "#{shared_path}/config/databases.yml", :mode => 0664

require 'yaml'
namespace :database do

  desc "creates database.yml file if none exists"
  task :create_database_file do
    on roles(:app) do
      within shared_path do
        if test "[ -f #{shared_path}/config/databases.yml ]"
          info "database file already exists"
          exit 0
        end
        execute :mkdir, "-p config"
        buffer = YAML::load_file("config/database.yml")
        buffer.delete('test')
        buffer.delete('development')
        buffer.delete('cucumber')
        # Populate production element
        env = fetch(:rails_env) || fetch(:stage)
        buffer["#{env}"]['username'] = "deploy"
        puts "Enter MySQL database password: "
        input = STDIN.gets.chomp
        buffer["#{env}"]['password'] = input
        execute :printf, "-- '#{YAML::dump(buffer)}' > #{shared_path}/config/databases.yml"
      end
    end
  end

end

namespace :load do
  task :defaults do
  end
end