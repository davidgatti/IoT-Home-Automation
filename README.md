![Alt text](https://github.com/davidgatti/IoT-Garage-Opener/blob/master/Assets/header.jpg "IoT Garage Opener")

# IoT-Garage-Opener
A simple project that uses a Particle to control a garage remote over the internet

# URLs

- https://www.hackster.io/davidgatti/garage-opener
- https://twitter.com/dawidgatti

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

