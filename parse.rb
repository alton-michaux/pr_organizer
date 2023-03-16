require 'nokogiri'
require_relative 'fetch.rb'

module Parser
  include FetchResponse
  class Parse
    document = Nokogiri::HTML4(FetchResponse.get_response)

    pulls = []

    all_pulls = document.css('div.Box-row--drag-hide')

    all_pulls.each do |pull|
      title = pull.css('.markdown-title > a > div')
      pulls << pull
    end

    pp document
  end
end
