![Alt text](https://github.com/davidgatti/IoT-Garage-Opener/blob/assets/Images/header.jpg "IoT Garage Opener")

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
- http://parse.com
- http://particle.io

# How to add seecrets to the project

![Alt text](https://github.com/davidgatti/IoT-Garage-Opener/blob/assets/Images/How%20to%20add%20plist.gif "How to add plist in Xcode")

In this project we are usign Particle and Parse. Two products that have cloud based services. For authntication they use tokesn and IDs. For safte reasons I can't attach thoes secrets to the proejct. Thus the requirment of the `Secrets.plist` file. 

The gif above shows you how to add key to the `plist` file. 

For Particle you will need the following keys

- ParticleToken
- ParticleDeviceID

For Parse you will need the following keys

- ParseAppID
- ParseClientID

Save, compile and enjoy :)

# The End

If you enjoyed this project, please consider giving it a 🌟. And check out my [GitHub account](https://github.com/davidgatti), where you'll find additional resources you might find useful or interesting.

## Sponsor 🎊

This project is brought to you by 0x4447 LLC, a software company specializing in building custom solutions on top of AWS. Follow this link to learn more: https://0x4447.com. Alternatively, send an email to [hello@0x4447.email](mailto:hello@0x4447.email?Subject=Hello%20From%20Repo&Body=Hi%2C%0A%0AMy%20name%20is%20NAME%2C%20and%20I%27d%20like%20to%20get%20in%20touch%20with%20someone%20at%200x4447.%0A%0AI%27d%20like%20to%20discuss%20the%20following%20topics%3A%0A%0A-%20LIST_OF_TOPICS_TO_DISCUSS%0A%0ASome%20useful%20information%3A%0A%0A-%20My%20full%20name%20is%3A%20FIRST_NAME%20LAST_NAME%0A-%20My%20time%20zone%20is%3A%20TIME_ZONE%0A-%20My%20working%20hours%20are%20from%3A%20TIME%20till%20TIME%0A-%20My%20company%20name%20is%3A%20COMPANY%20NAME%0A-%20My%20company%20website%20is%3A%20https%3A%2F%2F%0A%0ABest%20regards.).
