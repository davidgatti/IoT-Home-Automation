![Alt text](https://github.com/davidgatti/IoT-Garage-Opener/blob/master/Assets/header.jpg "IoT Garage Opener")

# IoT-Garage-Opener
A simple project that uses a Particle to control a garage remote over the internet

# URLs

- https://www.hackster.io/davidgatti/garage-opener
- https://twitter.com/dawidgatti

# How to add Particle Device ID and Token

![Alt text](https://github.com/davidgatti/IoT-Garage-Opener/blob/master/Assets/How%20to%20add%20plist.gif "How to add plist in Xcode")

Since this data is sensitive I had to make sure that I’m not releasing to the public the Token. Otherwise everybody would start to open and close my garage :) 

To add your own Device ID and Token. You have to add a plist to the project with two String Keys. Named:

- token
- deviceID

and of course add the appropriate value. Save the file and compile :)

# How to add Parse Application ID and Client Key

Well... you do it the same as you did with Particle. You add two new Keys to the Secrets.plist. In this case we are talkign about the following Keys names

- ParseAppID
- ParseClientID

Of course you need an account on [Parse](http://parse.com) :)

