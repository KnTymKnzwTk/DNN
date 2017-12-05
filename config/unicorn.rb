app_path = File.expand_path(File.dirname(__FILE__) + '/..')
 
worker_processes 2
listen '/tmp/unicorn.sock'
pid '/tmp/unicorn.pid'
timeout 300
working_directory app_path
pid app_path + '/tmp/unicorn.pid'
stderr_path app_path + '/log/unicorn.log'
stdout_path app_path + '/log/unicorn.log'
 
preload_app true
 
GC.respond_to?(:copy_on_write_friendly=) &&
GC.copy_on_write_friendly = true
 
before_fork do |server, worker|
defined?(ActiveRecord::Base) &&
ActiveRecord::Base.connection.disconnect!
end
 
after_fork do |server, worker|
defined?(ActiveRecord::Base) &&
ActiveRecord::Base.establish_connection
end
