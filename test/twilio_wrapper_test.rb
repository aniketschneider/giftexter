require 'test_helper'
require 'twilio_wrapper'

class TwilioWrapperTest < Minitest::Test
  # TODO: could test using Twilio test account instead of stubbing
  def test_send_gif_text
    messages = stub
    messages.expects(:create)
    account = stub(messages: messages)
    client = stub(account: account)
    Twilio::REST::Client.stubs(:new).returns(client)

    TwilioWrapper.send_gif_text("phone number", "message", "gif url")
  end
end
