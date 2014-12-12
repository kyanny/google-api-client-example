Google API Client (Ruby) samples
================================

My sample code snippets of Google OAuth 2.0 API Client (Ruby).

Requirements:

```
$ export GOOGLE_API_CLIENT_ID=XXX
$ export GOOGLE_API_CLIENT_SECRET=XXX
$ export GOOGLE_API_REFRESH_TOKEN=XXX
```

You must create your own OAuth 2.0 client at Google Developers Console.

To obtain refresh_token, you can use [kyanny/get-google-oauth-token](https://github.com/kyanny/get-google-oauth-token) :)

refresh_token.rb
----------------

Sample code to get fresh access_token by refresh_token.

drive.rb
--------

Sample code to upload CSV file to Google Drive (and make it to spreadsheet).
