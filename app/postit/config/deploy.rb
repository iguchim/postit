# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'postit'
# set :repo_url, 'git@example.com:me/my_repo.git'
set :repo_url, 'git@github.com:iguchim/postit.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/deploy/app/postit'

# masa added 2015.12.15
set :bundle_binstubs, nil

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# masa removed bin
#set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# masa added on 2015/12/15
set :rbenv_path, '/home/deploy/.rbenv/'

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  #> 上記linked_filesで使用するファイルをアップロードするタスク 
  #  deployが行われる前に実行する必要がある。
  desc 'upload importabt files'
  task :upload do
    on roles(:app) do |host|
      upload!('config/database.yml',"#{shared_path}/config/database.yml")
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
