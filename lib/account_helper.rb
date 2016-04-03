require "Pry"

class Account
  attr_reader :pattern, :icon
  attr_accessor :value

  def initialize(current_records = [])
    record = current_records.find do |item|
      matches = item["url"].match(pattern) || {}
      not matches[:account].nil?
    end
    @value = record["value"] if record
  end

  def json
    return nil if @value.nil?
    {
      icon: icon,
      value: value,
      url: url
    }
  end

  def question
    "#{@type} [#{@value || ''}]:\n> "
  end

  def value=(new_value)
    if new_value == "nil"
      @value = nil
    elsif not new_value.empty?
      @value = new_value
    end
  end
end


class Twitter < Account
  def initialize(current_records = [])
    @type = "Twitter account"
    @pattern = %r{.+twitter\.com/(?<account>.+)(/)?}
    @icon = "fa-twitter"
    super current_records
  end

  def url
    "https://twitter.com/#{@value || ''}"
  end
end


class Facebook < Account
  def initialize(current_records = [])
    @type = "Facebook account"
    @icon = "fa-facebook-official"
    @pattern = %r{.+facebook\.com/(?<account>.+)(/)?}
    super current_records
  end

  def url
    "https://www.facebook.com/#{@value || ''}"
  end
end


class GitHub < Account
  def initialize(current_records = [])
    @type = "GitHub account"
    @pattern = %r{.+github\.com/(?<account>.+)(/)?}
    @icon = "fa-github"
    super current_records
  end

  def url
    "https://github.com/#{@value || ''}"
  end
end


class Dribbble < Account
  def initialize(current_records = [])
    @type = "Dribbble account"
    @icon = "fa-dribbble"
    @pattern = %r{.+dribbble\.com/(?<account>.+)(/)?}
    super current_records
  end

  def url
    "https://dribbble.com/#{@value || ''}"
  end
end


class Behance < Account
  def initialize(current_records = [])
    @type = "Behance account"
    @icon = "fa-behance"
    @pattern = %r{.+behance\.net/(?<account>.+)(/)?}
    super current_records
  end

  def url
    "https://www.behance.net/#{@value || ''}"
  end
end


class Linkedin < Account
  def initialize(current_records = [])
    @type = "Linkedin account"
    @pattern = %r{.+linkedin\.com/in/(?<account>.+)(/)?}
    @icon = "fa-linkedin-square"
    super current_records
  end

  def url
    "https://www.linkedin.com/in/#{@value || ''}"
  end
end


class Email < Account
  def initialize(current_records = [])
    @type = "Email address"
    @pattern = /(?<account>.+\@.+)/
    @icon = "fa-envelope-o"
    super current_records
  end

  def url
    @value
  end
end
