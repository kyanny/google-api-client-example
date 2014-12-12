require 'google/api_client'
require 'csv'
require 'ffaker'
require 'securerandom'

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
client.authorization.refresh!

content = CSV.generate(headers: ['UUID', 'Name', 'State'], write_headers: true) do |csv|
  10.times do
    csv << [SecureRandom.uuid, Faker::Name.name, Faker::AddressUS.state]
  end
end

drive = client.discovered_api('drive', 'v2')
media = Google::APIClient::UploadIO.new(StringIO.new(content), 'text/csv')
file = drive.files.insert.request_schema.new({'title' => "User Address (State) Sheet #{Date.today}"})

result = client.execute(
  api_method:  drive.files.insert,
  body_object: file,
  media:       media,
  parameters: {
    'convert'    => true, # to google spreadsheet in this case
    'uploadType' => 'multipart',
    'alt'        => 'json',
  }
)

raise 'upload error' unless result.status == 200
