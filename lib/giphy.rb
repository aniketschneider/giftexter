require 'uri'
require 'faraday'
require 'json'
require 'erb'

class Giphy
  TRANSLATE_ENDPOINT_TEMPLATE =
    "http://api.giphy.com/v1/gifs/translate?s=%s&api_key=%s"

  def self.related_gif_url(text)
    encoded_text = URI.encode_www_form_component(text)
    request_url = TRANSLATE_ENDPOINT_TEMPLATE % [encoded_text, ENV["GIPHY_API_KEY"]]
    response = Faraday.get(request_url)
    if response.status != 200
      #throw an error
      "no gif here"
    else
      json_response = JSON.parse(response.body)
      json_response["data"]["images"]["downsized"]["url"]
    end
  end
end
