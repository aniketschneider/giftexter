# giftexter

A simple Sinatra app to text a message along with a related gif.

# Usage

To run locally:

```
bundle install
bundle exec rake test
bundle exec ruby ./giftexter.rb
```

You will need a `.env` file with appropriate config values. See `.env.sample` for formatting and required configuration.

The app is ready to be deployed to Heroku, but you will need to set the config variables (see `.env.sample`) remotely using `heroku config set KEY=<value>`

# Known Issues

* Sometimes Giphy will retrieve a gif that's too large for Twilio. Currently that will just fail to send. There appears to be a downsized version available through the Giphy API, but it's sometimes an mp4 instead of a gif, and sometimes just redirects to the original, so there's some refining to be done there.
* Currently there is no verification that the message actually gets sent. It's possible to check the status of a sent message through their API - it would be nice to do this asynchronously in the sent page.
