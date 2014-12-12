require 'google/api_client'

client_id     = ENV.fetch('GOOGLE_API_CLIENT_ID')
client_secret = ENV.fetch('GOOGLE_API_CLIENT_SECRET')
refresh_token = ENV.fetch('GOOGLE_API_REFRESH_TOKEN')

client = Google::APIClient.new(
  application_name:    'My App Name',
  application_version: '1.0.0',
)

client.authorization = Signet::OAuth2::Client.new(
  token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
  audience:             'https://accounts.google.com/o/oauth2/token',
  scope:                ['https://www.googleapis.com/auth/drive.file'],
  client_id:     client_id,
  client_secret: client_secret,
  refresh_token: refresh_token,
)

p client.authorization.access_token #=> nil

client.authorization.refresh!
p client.authorization.access_token

sleep 1

client.authorization.refresh!
p client.authorization.access_token
