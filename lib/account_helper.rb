require 'Pry'

class Account
  attr_reader :pattern, :json

  def initialize(current_records = [])
    @json = current_records.find do |item|
      matches = item['url'].match(pattern) || {}
      not matches[:account].nil?
    end
  end
end


class Twitter < Account
  def pattern
    /.+twitter\.com\/(?<account>.+)(\/)?/
  end
end


class GitHub < Account
  def pattern
    /.+github\.com\/(?<account>.+)(\/)?/
  end
end


class Linkedin < Account
  def pattern
    /.+linkedin\.com\/in\/(?<account>.+)(\/)?/
  end
end


class Email < Account
  def pattern
    /(?<account>.+\@.+)/
  end
end
