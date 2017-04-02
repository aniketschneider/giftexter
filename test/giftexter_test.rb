require 'test_helper'

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
end
