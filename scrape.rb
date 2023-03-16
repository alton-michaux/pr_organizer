require 'httparty'

module FetchResponse
  def self.get_response
    headers = { 
      "method" => "GET",
      "username"  => ENV["USERNAME"],
      "token" => ENV["ACCESS"]
    }

    response = HTTParty.get("#{ENV["BASE"]}",
      :headers => headers
    ).parsed_response
  end
end
