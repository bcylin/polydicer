require "highline"
require_relative "account_helper"

class Record

  attr_reader :cli, :json

  def json
    @me
  end

  def initialize(json, cli = HighLine.new)
    json ||= { "info" => [] }
    @me = json.clone
    @cli = cli
  end

  def gather_names
    fullname  = cli.ask "Your full name [#{@me['fullname'] || ''}]:\n> "
    nickname  = cli.ask "Your nickname [#{@me['nickname'] || ''}]:\n> "
    position  = cli.ask "Your job title [#{@me['position'] || ''}]:\n> "
    portfolio = cli.ask "Your portfolio URL (to generate QRCode) [#{@me['portfolio'] || ''}]:\n> "

    @me["fullname"] = fullname unless fullname.empty?
    @me["nickname"] = nickname unless nickname.empty?
    @me["position"] = position unless position.empty?
    @me["portfolio"] = portfolio unless portfolio.empty?

    Record.new @me
  end

  def gather_accounts
    info = @me["info"]
    @me["info"] = [
      Twitter,
      Facebook,
      GitHub,
      Dribbble,
      Behance,
      Linkedin,
      Email
    ].map { |type|
      account = type.new(info)
      account.value = cli.ask account.question
      account.json
    }.reject(&:nil?)

    Record.new @me
  end

  def save
    puts ""
    puts JSON.pretty_generate json
    puts ""
    ready = cli.ask "Looks good to overwrite me.json? (Y/n)\n> "

    puts ""
    if ["yes", "y", ""].include? ready.downcase
      File.open(self.class.gather_path, "w") { |file| file.write "#{JSON.pretty_generate json}\n" }
      puts "#{self.class.gather_path} is updated."
    else
      puts "Cancelled."
    end
  end

  # class methods

  def self.gather_path
    path
  end

  def self.current
    new current_record
  end

  def self.path
    File.expand_path "./data/me.json"
  end

  def self.current_record
    JSON.parse File.read path if File.exist? path
  end

  private_class_method :path, :current_record
end
