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
    )
    
    if response.code == 200
      response.body
    else
      response.body = "Error: #{response.code}"
    end  
  end
end
