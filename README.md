# shell_locked

Simple shell script for gpio control suitable for control from Android lock control app [Trigger](https://github.com/mwarning/trigger).

Assumes two pins:
* lock/close
* unlock/open

with momentary on each pin to actuate. Similar to https://github.com/h42i/d00r-key-server.

Recommended for use with [Trigger](https://github.com/mwarning/trigger) in ssh mode.

## Key Registration

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


In Trigger, enter in the registraion url, e.g. assuming server ip address is 192.168.1.1, enter in:

    tcp://192.168.1.1:50007

NOTE older versions of Trigger (1.9.1) should only specify
address and port and omit the `tcp://` prefix.

Older versions also need to specify registration URL before creating key.

Once key is created, hit Register in Trigger app on Android.


