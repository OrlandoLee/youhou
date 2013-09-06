task :default do
    Brakeman.run :app_path => ".", :print_report => true  
end
