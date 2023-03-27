require 'httparty'
require_relative '../google_services/google_sheets_service.rb'

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

    puts "Uploading new spreadsheet"

    response = service.create_spreadsheet(new_sheet)

    return response.spreadsheet_id
  end

  def self.update_csv
    spreadsheet_id = self.upload_csv

    puts "Done"

    service = GoogleSheetsService.service

    values = [ File.open('./csv/pulls.csv').read.to_json ]

    range = "Sheet1!A1"

    data = [Google::Apis::SheetsV4::ValueRange.new(values: values)]

    value_input_option = 'USER_ENTERED'

    puts "Uploading updates"

    response = service.append_spreadsheet_value(
      spreadsheet_id,
      range,
      data,
      value_input_option: value_input_option
    )
  end
end
