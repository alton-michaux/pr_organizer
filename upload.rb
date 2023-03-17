require_relative 'fetch.rb'
require_relative 'csv.rb'

include BuildCSV
include FetchResponse

CSVBuilder.create_csv
FetchResponse.upload_csv
