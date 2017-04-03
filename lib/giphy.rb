require 'uri'
require 'faraday'
require 'json'
require 'erb'

class Giphy
  TRANSLATE_ENDPOINT_TEMPLATE =
    "http://api.giphy.com/v1/gifs/translate?s=%s&api_key=%s"

  GIF_DIRECT_LINK_TEMPLATE = "http://i.giphy.com/%s.gif"

  def self.related_gif_url(text)
    encoded_text = URI.encode_www_form_component(text)
    request_url = TRANSLATE_ENDPOINT_TEMPLATE % [encoded_text, ENV["GIPHY_API_KEY"]]
    response = Faraday.get(request_url)
    if response.status != 200
      raise APIError
    else
      json_response = JSON.parse(response.body)
      gif_id = json_response["data"]["id"]
      GIF_DIRECT_LINK_TEMPLATE % gif_id
    end
  end

  class APIError < StandardError ; end
end
