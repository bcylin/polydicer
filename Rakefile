require 'highline'
require 'json'

task default: :init

task :init do
  puts "Update your me.json."
  puts ""

  cli = HighLine.new
  fullname  = cli.ask "Your full name: \n> "
  nickname  = cli.ask "Your nickname: \n> "
  position  = cli.ask "Your job title: \n> "
  portfolio = cli.ask "Your portfolio: \n> "
  twitter   = cli.ask "Twitter account: \n> "
  github    = cli.ask "GitHub account: \n> "
  linkedin  = cli.ask "Linkedin account: \n> "
  email     = cli.ask "Email account: \n> "

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
    portfolio: portfolio.empty? ? "https://github.com/bcylin/polydicer" : portfolio,
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
