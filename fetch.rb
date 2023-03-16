require 'httparty'

module FetchResponse
  def self.get_response
    headers = { 
      "username": ENV["USERNAME"],
      "Accept": "application/vnd.github+json",
      "Authorization": "Bearer #{ENV["ACCESS"]}",
      "X-GitHub-Api-Version": "2022-11-28"
    }

    response = HTTParty.get("#{ENV["BASE"]}#{ENV["EXTENSION"]}", headers: headers)

    if response.code == 200
      response.body
    else
      response.body = "ERROR #{response.code}: #{response.message}"
    end
  end
end
