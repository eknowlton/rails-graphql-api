#!/usr/bin/env ruby
require 'fileutils'
require 'erb'
require_relative '../lib/env_generator'

include FileUtils

# path to your application root.
APP_ROOT = File.expand_path('..', __dir__)

def system!(*args)
  system(*args) || abort("\n== Command #{args} failed ==")
end

def ask(question, default: nil)
  question = "#{question} |#{default}|" if default
  puts question
  input = STDIN.gets.chomp
  if !input.empty?
    input
  else
    default
  end
end

chdir APP_ROOT do
  # This script is a starting point to setup your application.
  # Add necessary setup steps to this file.

  # Verify that brew is installed
  which_brew = `which brew`

  if ! which_brew.include? 'brew'
    puts "!!! Homebrew was not found. Please install homebrew before setup."
    exit
  end

  # Gather configuration values
  puts "\n== Application Configuration Setup =="
  application = {}
  puts "The Rails Master Key can be found in the team 1Password as 'Central API Master Key'"
  application[:rails_master_key] = ask('Rails Master Key?')

  puts "\n== Database Configuration Setup =="
  database = {}
  database[:host] = ask('Database host?', default: 'localhost')
  database[:name] = ask('Database name?', default: 'central')
  database[:username] = ask('Database username?', default: 'root')
  database[:password] = ask('Database password?')

  EnvGenerator.new(application: application, database: database).call

  puts "\n== Installing System Dependencies =="

  if ! system('brew ls --versions cmake')
    puts 'Installing "cmake" via Homebrew ... '
    system 'brew install cmake'
  else
    puts 'Homebrew "cmake" is already installed.'
  end

  puts "\n== Installing dependencies =="
  system! 'gem install bundler --conservative'
  system('bundle check') || system!('bundle install')

  puts "\n== Preparing database =="
  system! 'bin/rails db:drop db:create db:migrate db:seed'

  puts "\n== Removing old logs and tempfiles =="
  system! 'bin/rails log:clear tmp:clear'
end