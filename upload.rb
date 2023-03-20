require_relative 'fetch.rb'
require_relative 'csv.rb'

module Upload
  include BuildCSV
  include FetchResponse
  
  CSVBuilder.create_csv
  FetchResponse.upload_csv
end
