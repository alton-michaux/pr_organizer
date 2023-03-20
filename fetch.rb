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

    if response.code == 200
      response
    else
      "ERROR: #{response.message}"
    end
  end

  def self.upload_csv
    options = {
      headers: {
        'Transfer-Encoding': 'chunked',
        'Authorization': "Bearer #{ENV["ACCESS_TOKEN"]}",
        'Content-Type': 'text/csv',
        'Accept': 'application/json'
      },
      body: {
        media: File.open('./pulls.csv').read.to_json
      }
    }

    response = HTTParty.post(
      "#{ENV["SERVICE_ENDPOINT"]}v4/spreadsheets",
      options
    )

    if response.code == 200 
      puts response 
    else
      puts "ERROR: #{response.message}"
    end
  end
end
