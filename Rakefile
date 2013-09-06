# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Youhou::Application.load_tasks
task :default do
    Brakeman.run :app_path => ".", :print_report => true  
end
