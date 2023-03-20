require 'byebug'
require_relative 'fetch.rb'

module Parser
  include FetchResponse
  def self.parse_pull_requests
    response = FetchResponse.get_response

    pulls = {}

    response.each do |pull|
      if pull["state"] == "open"
        title = pull["title"]
        url = pull["html_url"]
        pulls[title] = url
      end
    end

    puts "retrieved data"
    pulls
  end
end
