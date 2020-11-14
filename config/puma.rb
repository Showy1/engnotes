# w/o Docker
# max_threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
# min_threads_count = ENV.fetch('RAILS_MIN_THREADS') { max_threads_count }
# threads min_threads_count, max_threads_count
# port        ENV.fetch('PORT') { 3000 }
# environment ENV.fetch('RAILS_ENV') { 'development' }
# pidfile ENV.fetch('PIDFILE') { 'tmp/pids/server.pid' }
# plugin :tmp_restart

# w/ Docker
threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }.to_i
threads threads_count, threads_count
port        ENV.fetch('PORT') { 3000 }
environment ENV.fetch('RAILS_ENV') { 'development' }
# environment ENV.fetch('RAILS_ENV') { 'production' }
plugin :tmp_restart

app_root = File.expand_path('..', __dir__)
bind "unix://#{app_root}/tmp/sockets/puma.sock"

stdout_redirect "#{app_root}/log/puma.stdout.log", "#{app_root}/log/puma.stderr.log", true
