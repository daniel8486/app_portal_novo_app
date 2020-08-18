root = "/var/www/app_portal_novo_app/current" 
working_directory root

pid "#{root}/tmp/pids/unicorn.pid"

stderr_path "#{root}/log/unicorn.log" 
stdout_path "#{root}/log/unicorn.log"

worker_processes 4 
timeout 30 
preload_app true

listen '/tmp/app_portal_novo_app.sock', backlog: 64