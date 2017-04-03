
* Styling. Right now the UI is simple but drab. Bootstrap might be a good starting point.
* GIF validation. Giphy can reference files that are too large to be sent via MMS. This case needs to be handled in a reasonable manner. Figuring out how to direct link to the downsized version of the image would be ideal. The size of the gif can also be confirmed via the API.
* Confirmation of send. I envision a little js widget that pings the Twilio API to monitor the status of the message until it is successfully sent or fails, letting the user know the outcome.
* User feedback on error. A lot of things can go wrong in the process of sending a gif, and right now they all just lead to the same generic error page. The user should be notified about what exactly went wrong.
* Twilio wrapper refactor. The configuration should happen out in the app itself and get passed in explicitly.
* Unhack Giphy wrapper. The static url template for the direct gif link is a hack that doesn't allow for retrieving different versions of the image. The image URLs returned by the API, however, cause a content-type error when Twilio attempts to retrieve the image because Giphy redirects to a javascript-wrapped version of the image with sharing links under some circumstances. There must be some way around this - perhaps it's possible to adjust the headers sent when Twilio requests the media.
