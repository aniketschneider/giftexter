require 'test_helper'
require 'giphy'
require 'json'

class GiphyTest < Minitest::Test
  def test_related_gif_url
    stub_text = "a text message"
    stub_url = "http://www.example.com/example.gif"
    stub_response = Object.new
    stub_response.stubs(:status).returns(200)
    stub_response.stubs(:body).returns(
      {
        data: {
          images: {
            downsized: {
              url: stub_url
            }
          }
        }
      }.to_json)

    Faraday.stub(:get, stub_response) do
      assert_equal(stub_url, Giphy.related_gif_url(stub_text))
    end
  end
end
