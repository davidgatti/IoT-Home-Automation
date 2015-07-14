# NodeJS Proxy App

This branch is only used when you are buildign the IoT Water Flow Meter, since that project is esentialy a data logger. Which means that we wait for water to flow, collect the data, and send it to Parse.com. For this to happen we need to make RESTfull API calls. 

This can be done using the Webhook feature that Particle is providing. But, as you can imagine there is an issue. For some reason people at Particle decided to add additional data to the JSON blob that you send out. Because of this, Parse is unable to process the incoming request. 

You can read more about this issue in the [forum post](https://community.particle.io/t/webhooks-parse-com/13010). One of the developer sad it will work to fix this issue but the time frame is known. Because of this I decided to just write the proxy and get over this issue. 

# Hosting

This app needs to be hosted somwhere. I choose Heroku, but you can host this app anywhere where NodeJS is supported.
