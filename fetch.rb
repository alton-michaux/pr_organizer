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
    # new_sheet.sheets = File.open('./pulls.csv').read.to_json

    # byebug

    response = service.create_spreadsheet(new_sheet)
  end
end
