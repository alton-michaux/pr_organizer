require 'dotenv'

Dotenv.load

require_relative 'fetch.rb'
require_relative 'csv.rb'

module Upload
  include BuildCSV
  include FetchResponse

  puts "Starting up..."
  
  CSVBuilder.create_csv

  puts "Created CSV"

  FetchResponse.update_csv

  puts "Spreadsheet uploaded"
end
