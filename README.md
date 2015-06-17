![Alt text](https://github.com/davidgatti/IoT-Garage-Opener/blob/master/Assets/header.jpg "IoT Garage Opener")

# IoT-Garage-Opener
The problem: many people under on roof and just one remote for the garage. Solution? Connect the remote to the internets and write an iOS app to trigger the remote over the internet.

It started as a simple project ;) and now you can:

- Store the whole history of open and closes thanks to Parse.com
- Store the amount of uses 
- Store the state of the door
- Detect if the physical remote was used, not yet saved on Parse.com

# URLs

- https://www.hackster.io/davidgatti/garage-opener
- https://twitter.com/dawidgatti
- parse.com
- particle.io

# How to add tokens and seecrets to the project

![Alt text](https://github.com/davidgatti/IoT-Garage-Opener/blob/master/Assets/How%20to%20add%20plist.gif "How to add plist in Xcode")

In this project we are usign Particle and Parse. Two products that have cloud based services. For authntication they use tokesn and IDs. For safte reasons I can't attach thoes secrets to the proejct. Thus the requirment of the `Secrets.plist` file. 

The gif above shows you how to add key to the `plist` file. 

For Particle you will need the following keys

- ParticleToken
- ParticleDeviceID

For Parse you will need the following keys

- ParseAppID
- ParseClientID

Save, compile and enjoy :)

