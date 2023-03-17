require 'csv'
require_relative 'parse.rb'

module BuildCSV
  include Parser
  class CSVBuilder
    pulls = Parser.parse_pull_requests

    CSV.open('pulls.csv', 'w+',
      write_headers: true,
      headers: %w[Title URL]) do |csv|

      pulls.each do |pull|
        csv << pull
      end
    end
  end
end
