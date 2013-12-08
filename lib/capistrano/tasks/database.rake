
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

