# frozen_string_literal: true

namespace :cardwalls do
  desc 'Create configuration file'
  task :config do
    template 'settings.yml.erb', "#{release_path}/config/settings.yml"
  end
end
