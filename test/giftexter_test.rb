require 'test_helper'
require 'giphy'
require 'twilio_wrapper'

class GiftexterTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get '/'
    assert last_response.ok?
    assert_match "Send a Text", last_response.body
  end

  def test_send
    phone_number = "stub phone number"
    message = "stub message"
    gif_url = "http://example.com/stub.gif"

    Giphy.expects(:related_gif_url).returns(gif_url)
    TwilioWrapper.expects(:send_gif_text)

    post '/send', params={ phone_number: phone_number, message: message }

    assert last_response.ok?
    assert_match gif_url, last_response.body
  end

  def test_send_error
    phone_number = "stub phone number"
    message = "stub message"
    gif_url = "http://example.com/stub.gif"

    Giphy.expects(:related_gif_url).raises(Giphy::APIError)

    post '/send', params={ phone_number: phone_number, message: message }

    assert last_response.ok?
    assert_match "error", last_response.body
  end
end
