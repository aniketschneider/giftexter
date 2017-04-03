lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'giphy'
require 'twilio_wrapper'

require 'sinatra'
require 'slim'
require 'twilio-ruby'

require 'dotenv'
Dotenv.load


get '/' do
  slim :index
end

post '/send' do
  # TODO: validate that it's a proper phone number
  phone_number = params["phone_number"]
  message = params["message"]

  begin
    gif_url = Giphy.related_gif_url(message)
    TwilioWrapper.send_gif_text(phone_number, message, gif_url)
    slim :sent, locals: { gif_url: gif_url }
  rescue
    slim :error
  end
end


__END__

# The app is pretty small right now, so I think it's reasonable to leave these
# templates inline. Soon, however, they will have to be broken out into
# separate files.

@@layout
doctype html
html
  head
    meta charset="utf-8"
    title Giftexter!
  body
    h1 Giftexter!
    == yield

@@index
h2 Send a Text With a Related Gif
== slim :input_form

@@sent
h2 Sent this gif with your message:
img src="#{gif_url}"
h2 Send Another?
== slim :input_form

@@error
h2 Encountered an error sending that message
h2 Try again?
== slim :input_form

@@input_form
form action="/send" method="POST"
    label for="phone_number" Send to phone number:
    br
    input type="text" name="phone_number"
    br
    label for="message" Message:
    br
    input type="text" name="message"
    br
    input.button type="submit" value="Send"
