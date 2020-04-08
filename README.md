# shell_locked

Simple shell script for gpio control suitable for control from Android lock control app [Trigger](https://github.com/mwarning/trigger) in ssh mode. See https://github.com/clach04/pirest for https mode server.

Assumes two pins:
* lock/close
* unlock/open

with momentary on each pin to actuate. Similar to https://github.com/h42i/d00r-key-server.

Recommended for use with Android [Trigger](https://github.com/mwarning/trigger) app in ssh mode.

## Setup

NOTE `door.sh` needs to be edited to set the GPIO pins.

In addition it needs to be called in `setup` mode. If any other process access/changes the GPIO pins, e.g. a python script, setup needs to be ran again. Set and unset of GPIO pins will silently fail.

## Key Registration Server for Trigger

Can either perform regular ssh key generation/registration or make use of Trigger's key creation mode.

Ensure `.ssh` directory exists and has correct permissions:

    cd
    chmod a-w .
    chmod u+rwx  .
    ls -altrd .
    mkdir .ssh
    chmod a-rwx .ssh
    chmod u+rwx  .ssh
    ls -ald .ssh

Run registration server:

    ./keyreg.py
    # or
    ./keyreg.py ~/.ssh/authorized_keys


In Trigger, enter in the registration url, e.g. assuming server ip address is 192.168.1.1, enter in:

    tcp://192.168.1.1:50007

NOTE older versions of Trigger (1.9.1) should only specify
address and port and omit the `tcp://` prefix.

Older versions also need to specify registration URL before creating key.

Once key is created, hit Register in Trigger app on Android.

