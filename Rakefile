require 'highline'
require 'json'
require_relative 'lib/account_helper'

task default: :init

desc "Show git remote name based on the github account in me.json"
task :remote do
  if File.exist? "./data/me.json"
    json = JSON.parse File.read("./data/me.json")
    github = json["info"].select { |item| item["url"].start_with? "https://github.com/" }.first if json["info"]
    puts github["value"] if github
  end
end

desc "Create me.json"
task :init do
  puts "Update your me.json."
  puts ""

  cli = HighLine.new
  fullname  = cli.ask "Your full name: \n> "
  nickname  = cli.ask "Your nickname: \n> "
  position  = cli.ask "Your job title: \n> "
  portfolio = cli.ask "Your portfolio (URL to generate QRCode): \n> "
  twitter   = cli.ask "Twitter account: \n> "
  github    = cli.ask "GitHub account: \n> "
  linkedin  = cli.ask "Linkedin account: \n> "
  email     = cli.ask "Email address: \n> "

  puts ""
  info = []

  unless twitter.empty?
    info.push({
      icon: "fa-twitter",
      value: twitter,
      url: "https://twitter.com/#{twitter}"
    })
  end

  unless github.empty?
    info.push({
      icon: "fa-github",
      value: github,
      url: "https://github.com/#{github}"
    })
  end

  unless linkedin.empty?
    info.push({
      icon: "fa-linkedin-square",
      value: "linkedin.com/in/#{linkedin}",
      url: "https://www.linkedin.com/in/#{linkedin}"
    })
  end

  contact = email.empty? ? "me@polydice.com" : email
  info.push({
    icon: "fa-envelope-o",
    value: contact,
    url: "mailto:#{contact}"
  })

  me = {
    fullname: fullname.empty? ? "Polydicer" : fullname,
    nickname: nickname,
    position: position.empty? ? "Job Title" : position,
    portfolio: portfolio.empty? ? "https://bcylin.github.io/polydicer" : portfolio,
    info: info
  }

  path = File.expand_path "./data/me.json"
  File.open(path, "w") do |file|
    file.write "#{JSON.pretty_generate me}\n"
    puts "#{path} is updated."
    puts ""
    puts JSON.pretty_generate me
  end
end


namespace :update do
  desc "Update names, job title, and portfolio URL in me.json"
  task :names do
    path = File.expand_path "./data/me.json"
    me = JSON.parse File.read path if File.exist? path
    me ||= {
      "info" => []
    }

    cli = HighLine.new
    fullname  = cli.ask "Your full name: (#{me['fullname'] || ''})\n> "
    nickname  = cli.ask "Your nickname: (#{me['nickname'] || ''})\n> "
    position  = cli.ask "Your job title: (#{me['position'] || ''})\n> "
    portfolio = cli.ask "Your portfolio URL (to generate QRCode): (#{me['portfolio'] || ''})\n> "

    me["fullname"] = fullname unless fullname.empty?
    me["nickname"] = nickname unless fullname.empty?
    me["position"] = position unless fullname.empty?
    me["portfolio"] = portfolio unless fullname.empty?

    puts ""
    puts JSON.pretty_generate me
    ready = cli.ask "Looks good to update me.json? (Y/n)\n> "

    puts ""
    if ["yes", "y", ""].include? ready.downcase
      File.open(path, "w") { |file| file.write "#{JSON.pretty_generate me}\n" }
      puts "#{path} is updated."
    elsif
      puts "Cancelled."
    end
  end
end


task :test do
  path = File.expand_path "./data/me.json"
  me = JSON.parse File.read path if File.exist? path
  me ||= {
    "info" => []
  }
  info = me["info"]

  [Twitter, GitHub, Linkedin, Email].each do |type|
    puts type.new(info).json
  end
end
