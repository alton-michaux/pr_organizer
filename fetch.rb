require 'httparty'

module FetchResponse
  def self.get_response
    headers = { 
      "username": ENV["USERNAME"],
      "Accept": "application/vnd.github+json",
      "Authorization": "Bearer #{ENV["ACCESS"]}",
      "X-GitHub-Api-Version": "2022-11-28"
    }

    response = HTTParty.get("#{ENV["BASE"]}CodeTheDream/rsites-api/pulls", headers: headers).parsed_response
  end
end
