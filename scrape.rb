require 'httparty'

module FetchResponse
  def self.get_response
    response = HTTParty.get('https://github.com/CodeTheDream/rsites-api/pulls')
    
    if response.code == 200
      response.body
    else
      response.body = "Error: #{response.code}"
    end  
  end
end
