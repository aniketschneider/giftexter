lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'giphy'

require 'sinatra'
require 'slim'
require 'twilio-ruby'

require 'dotenv'
Dotenv.load


get '/' do
  slim :index
end

post '/' do
  logger.info(params)
  # should validate phone number
  phone_number = params["phone_number"]
  gif_url = Giphy.related_gif_url(params["message"])
  logger.info(gif_url)
  send_gif_text(phone_number, params["message"], gif_url)
  slim :sent
end

def send_gif_text(phone_number, text, gif_url)
  account_sid = ENV["TWILIO_ACCOUNT_SID"]
  auth_token = ENV["TWILIO_AUTH_TOKEN"]

  client = Twilio::REST::Client.new account_sid, auth_token

  text_with_gif = "#{text}\n#{gif_url}"
  
  client.account.messages.create({
    :from => ENV["TWILIO_FROM_NUMBER"],
    :to => phone_number, 
    :body => text_with_gif,
    :media_url => gif_url
  })
end


__END__

@@layout
doctype html
html
  head
    meta charset="utf-8"
    title Giftexter!
    link rel="stylesheet" media="screen,projection" href="/styles.css"
  body
    h1 Giftexter!
    == yield

@@index
h2 Send a Text With a Related Gif
== slim :input_form

@@sent
h2 Send a Text With a Related Gif
== slim :input_form

@@input_form
form action="/" method="POST"
    label for="phone_number" Send to phone number:
    br
    input type="text" name="phone_number"
    br
    label for="message" Message:
    br
    input type="text" name="message"
    br
    input.button type="submit" value="Send"
