class TwilioWrapper
  # TODO: separate configuration from logic
  def self.send_gif_text(phone_number, text, gif_url)
    account_sid = ENV["TWILIO_ACCOUNT_SID"]
    auth_token = ENV["TWILIO_AUTH_TOKEN"]

    client = Twilio::REST::Client.new account_sid, auth_token

    client.account.messages.create({
      :from => ENV["TWILIO_FROM_NUMBER"],
      :to => phone_number, 
      :body => text,
      :media_url => gif_url
    })
  end
end
