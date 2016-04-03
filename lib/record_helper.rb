require 'highline'
require_relative 'account_helper'

class Record

  attr_reader :json, :cli

  def json
    @me
  end

  def initialize(json = { "info" => [] }, cli = HighLine.new)
    @me = json.clone
    @cli = cli
  end

  def self.current
    self.new current_me
  end

  def gather_names
    fullname  = cli.ask "Your full name [#{me['fullname'] || ''}]:\n> "
    nickname  = cli.ask "Your nickname [#{me['nickname'] || ''}]:\n> "
    position  = cli.ask "Your job title [#{me['position'] || ''}]:\n> "
    portfolio = cli.ask "Your portfolio URL (to generate QRCode) [#{me['portfolio'] || ''}]:\n> "

    me["fullname"] = fullname unless fullname.empty?
    me["nickname"] = nickname unless fullname.empty?
    me["position"] = position unless fullname.empty?
    me["portfolio"] = portfolio unless fullname.empty?

    Record.new me
  end

  def gather_accounts
    info = me["info"]
    me["info"] = [
      Twitter,
      GitHub,
      Linkedin,
      Email
    ].map { |type|
      account = type.new(info)
      account.value = cli.ask account.question
      account.json
    }.reject(&:nil?)

    Record.new me
  end

  def self.write(record)
    puts ""
    puts JSON.pretty_generate record.json
    puts ""
    ready = record.cli.ask "Looks good to overwrite me.json? (Y/n)\n> "

    puts ""
    if ["yes", "y", ""].include? ready.downcase
      File.open(path, "w") { |file| file.write "#{JSON.pretty_generate record.json}\n" }
      puts "#{path} is updated."
    elsif
      puts "Cancelled."
    end
  end

  private

  attr_reader :me

  def self.path
    File.expand_path "./data/me.json"
  end

  def self.current_me
    JSON.parse File.read path if File.exist? path
  end

end
