require 'test_helper'
require 'giphy'
require 'json'

class GiphyTest < Minitest::Test
  DIRECT_LINK_TEMPLATE = "http://i.giphy.com/%s.gif"

  def test_related_gif_url
    stub_text = "a text message"
    stub_id = "stub_id"
    stub_url = "http://i.giphy.com/#{stub_id}.gif"

    response = stub
    response.stubs(:status).returns(200)
    response.stubs(:body).returns(
      {
        data: {
          id: stub_id
        }
      }.to_json
    )

    Faraday.stubs(:get).returns(response)

    assert_equal(stub_url, Giphy.related_gif_url(stub_text))
  end
end
