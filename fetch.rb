require 'httparty'

module FetchResponse
  def self.get_response
    headers = { 
      "username": ENV["USERNAME"],
      "Accept": "application/vnd.github.v3.text-match+json",
      "Authorization": "Bearer #{ENV["ACCESS"]}",
      "X-GitHub-Api-Version": "2022-11-28"
    }

    query = { q: "issue" }

    response = HTTParty.get("#{ENV["BASE"]}#{ENV["EXTENSION"]}", query: query, headers: headers).parsed_response
  end

  def self.upload_csv
    headers = {
      'Transfer-Encoding': 'chunked',
      'Authorization': "Bearer #{ENV["ACCESS_TOKEN"]}",
      'Content-Type': "text/csv",
      'Accept': 'application/json'
    }

    response = HTTParty.post(
      "https://sheets.googleapis.com/v4/spreadsheets",
      headers: headers,
      body_stream: File.open('./pulls.csv', 'r')
    )

    if response.code == 200 
      puts response 
    else 
      puts "ERROR: #{response.message}"
    end
  end
end
