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

    # if response.code == 200
    #   response.body
    # else
    #   response.body = "ERROR #{response.code}: #{response.message}"
    # end
  end
end
