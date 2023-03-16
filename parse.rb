require 'nokogiri'
require_relative 'fetch.rb'

module Parser
  include FetchResponse
  class Parse
    # document = Nokogiri::HTML4(FetchResponse.get_response)

    pp FetchResponse.get_response
  end
end
