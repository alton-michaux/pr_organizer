require 'googleauth'

module GoogleCredentials
  CLIENT_ID = ENV['CLIENT_ID']
  CLIENT_SECRET = ENV['CLIENT_SECRET']
  REFRESH_TOKEN = ENV['REFRESH_TOKEN']
  SCOPES = [
    'https://www.googleapis.com/auth/spreadsheets',
  ].freeze

  def make_credentials!
    creds = Google::Auth::UserRefreshCredentials.new(credentials_config)
    creds.refresh_token = REFRESH_TOKEN
    creds.fetch_access_token!
    creds
  end

  def credentials_config
    {
      client_id: CLIENT_ID,
      client_secret: CLIENT_SECRET,
      scope: SCOPES,
      additional_parameters: { 'access_type' => 'offline' },
    }
  end
end