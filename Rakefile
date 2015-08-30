begin
  require 'rubygems'
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

begin
  require 'rspec'
rescue LoadError
  puts 'You must `gem install rspec` to run tests'
end

APP_RAKEFILE = File.expand_path('../spec/test_app/Rakefile', __FILE__)
load 'rails/tasks/engine.rake'

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new(:spec)
