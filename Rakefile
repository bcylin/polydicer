require "highline"
require "json"
require_relative 'lib/record_helper'

task default: :init

desc "Create me.json"
task :init do
  puts ""
  puts "Setting up your me.json:"
  puts ""
  Record.current.gather_names.gather_accounts.save
end

desc "Show the remote name based on the github account in me.json"
task :remote do
  if File.exist? "./data/me.json"
    json = JSON.parse File.read("./data/me.json")
    github = json["info"].find { |item| item["url"].start_with? "https://github.com/" } if json["info"]
    puts github["value"] if github
  end
end

namespace :update do
  desc "Update names, job title, and portfolio URL in me.json"
  task :names do
    puts ""
    puts "Updating your names in me.json. Current values are displayed in square brackets."
    puts "* Leave blank to skip updating"
    puts ""
    Record.current.gather_names.save
  end

  desc "Update contact info in me.json"
  task :info do
    puts ""
    puts "Updating social accounts in me.json. Current values are displayed in square brackets."
    puts "* Leave blank to skip updating"
    puts "* Input nil to remove the account"
    puts ""
    Record.current.gather_accounts.save
  end
end
