require 'mailgun'

# rubocop:disable all

def send_token email, token
  RestClient.post "https://api:key-3e7abcdcb9f2386d15e5f549f12981e8"\
  "@api.mailgun.net/v3/sandboxc183caeed9d4460da2974a4de8162f9e.mailgun.org/messages",
  :from => "Mailgun Sandbox <postmaster@sandboxc183caeed9d4460da2974a4de8162f9e.mailgun.org>",
  :to => email,
  :subject => "Hello Andrea",
  :text => "You can reset your password here: http://localhost:9292/reset_password/#{token}"
end
