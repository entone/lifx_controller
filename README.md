# LifxController

This is a demo app for the talk I gave on [October 26th, 2016 at ChicagoElixir](http://www.meetup.com/ChicagoElixir/events/234678335/)

The app serves a simple web app available at [http://lifx.local:8800](http://lifx.local:8800) for controlling a [Lifx lightbulb](http://www.lifx.com/). It runs on a [Raspberry Pi 2 Model B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/) with a [Canakit Wifi dongle](https://www.canakit.com/raspberry-pi-wifi.html) using [Nerves](http://nerves-project.org/) to build the embedded Linux/Elixir environment.

## Getting Started

First things first, you'll need to install the nerves system.

`mix archive.install https://github.com/nerves-project/archives/raw/master/nerves_bootstrap.ez`

Next clone this repo `git clone https://github.com/NationalAssociationOfRealtors/lifx_controller.git`

Copy `default.env` to `.env` and change the variables as needed to set your SSID and PSK.

If you plan on burning an SD Card and running it on a Raspberry Pi, make sure to set `NERVES=true` otherwise keep it as `NERVES=false`.

To build `Nerves` systems you must run Linux, I also recommend running the app in a Linux environment, as it hasn't been tested outside of that.

If you are running the app locally in a VM you will need to adjust the `INTERFACE` variable. Run `ifconfig` in your VM to figure out the correct interface. Also, because the Lifx library uses UDP broadcasting you will most likely need to setup the VM network in `Bridged Adaptor` mode and select the network interface from your host machine

#### To burn your Nerves app to an SD Card:
  * Install your enviornment variables `source .env` *you'll need to do this for each new terminal window*
  * Install dependencies with `mix do deps.get, deps.compile`
  * Create firmware with `mix firmware`
  * Burn to an SD card with `mix firmware.burn`
  * Install SD Card in Pi
  * Power On
  * Browse to [http://lifx.local:8800](http://lifx.local:8800)

The default settings for this app pipe the Elixir console over the Raspberry Pi's serial console, use a USB -> Serial cable, like this [https://www.adafruit.com/products/954](https://www.adafruit.com/products/954) to view boot messages and access the Elixir console. Running `screen /dev/ttyUSB0 115200` is a super easy way to access the serial console on your host machine.

#### To run the app locally
  * Install your enviornment variables `source .env` *you'll need to do this for each new terminal window*
  * Install dependencies with `mix do deps.get, deps.compile`
  * run `iex -S mix` to get an interactive console
  * Browse to [http://lifx.local:8800](http://lifx.local:8800)

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: http://www.nerves-project.org/
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves
  * Lifx Library [http://github.crtlabs.org/lifx](http://github.crtlabs.org/lifx)
  * mDNS Library [http://github.crtlabs.org/mdns](http://github.crtlabs.org/mdns)
