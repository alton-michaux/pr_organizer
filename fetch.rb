require 'httparty'
require_relative 'google_sheets_service.rb'

module FetchResponse
  def self.get_response
    headers = { 
      "username": ENV["USERNAME"],
      "Accept": "application/vnd.github.v3.text-match+json",
      "Authorization": "Bearer #{ENV["ACCESS"]}",
      "X-GitHub-Api-Version": "2022-11-28"
    }

    url = "#{ENV["BASE"]}#{ENV["CTD_REPOS"]}"

    query = { q: "issue" }

    response = HTTParty.get(url, query: query, headers: headers).parsed_response
  end

  def self.upload_csv
    service = GoogleSheetsService.service
    
    sheet_name = "PRs for Review"

    new_sheet = Google::Apis::SheetsV4::Spreadsheet.new
    new_sheet.properties = Google::Apis::SheetsV4::SheetProperties.new
    new_sheet.properties.title = sheet_name

    response = service.create_spreadsheet(new_sheet)
  end

  def self.update_csv
    service = GoogleSheetsService.service

    values = [ File.open('./pulls.csv').read.to_json ]

    range = "WorksheetInParentSpreadsheet!A1:M"

    data = Google::Apis::SheetsV4::ValueRange.new
    data.values = [values]
    data.major_dimension = 'ROWS'

    spreadsheet = `spreadsheet_object`
    request = Google::Apis::SheetsV4::BatchUpdateValuesRequest.new

    request.data = [data] # <--- Modified

    request.value_input_option = 2
    data.range = range

    service.batch_update_values(ENV["SPREADSHEET_ID"], request)
    # url = "https://sheets.googleapis.com/v4/spreadsheets/#{ENV['SPREADSHEET_ID']}:batchUpdate"
    response = service.batchUpdate
  end
end
