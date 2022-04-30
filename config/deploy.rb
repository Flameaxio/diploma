# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.17.0'

set :rvm_ruby_version, '2.5.1'

set :application, 'diploma'
set :repo_url, 'git@github.com:Flameaxio/diploma.git'
set :rvm_custom_path, '/usr/share/rvm'

set :nvm_type, :user # or :system, depends on your nvm setup
set :nvm_node, 'v12.22.11'
set :nvm_map_bins, %w{node npm yarn}
set :nvm_custom_path, '/home/deploy/.nvm'

load 'config/recipes/base.rb'
load 'config/recipes/cardwalls.rb'

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

append :linked_files, 'config/master.key'
before 'deploy:migrate', 'cardwalls:config'

namespace :deploy do
  namespace :check do
    before :linked_files, :set_master_key do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/master.key ]")
          upload! 'config/master.key', "#{shared_path}/config/master.key"
        end
      end
    end
  end
end
