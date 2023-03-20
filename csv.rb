require 'csv'
require_relative 'parse.rb'

module BuildCSV
  include Parser
  class CSVBuilder
    def self.create_csv
      pulls = Parser.parse_pull_requests

      CSV.open('pulls.csv', 'w+',
        write_headers: true,
        headers: %w[Title Url]) do |csv|

        pulls.each do |pull|
          csv << pull
        end
      end
    end
  end
end
