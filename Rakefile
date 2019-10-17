require "sinatra/activerecord/rake"
require 'irb'

namespace :db do
  task :load_config do
    require "./app/main"
  end
end

desc "console"
task :console do
  require "./app/main"
  ARGV.clear  # To prevent `Errno::ENOENT: No such file or directory @ rb_sysopen - console`
  IRB.start
end

desc "Run tests"
task :spec do
  sh "bundle exec rspec"
end

task default: :spec

namespace :docker do
  task :build do
    sh "docker build -t deck-royale ."
  end

  task :run do
    sh "docker run --rm -p3000:3000 -vdb:/app/db deck-royale"
  end
end

namespace :cr do
  require "./lib/cr"

  desc "Reload card data"
  task :sync do
    require "./app/main"
    CR.sync_cards
    CR.sync_images
    puts "sync done."
  end

  task :sync_cards do
    require "./app/main"
    CR.sync_cards
  end
end
