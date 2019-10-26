#!/bin/sh
# Lock demo, suitable for use with ssh mode of https://github.com/mwarning/trigger
# Relys on gpio command line tool for wiringPi
# http://wiringpi.com/the-gpio-utility/

COMMAND=$1

# constants
LOCK_GPIO=17
UNLOCK_GPIO=27
SLEEP=0.5

status=LOCKED
case ${COMMAND} in
    setup)
        gpio -g mode ${LOCK_GPIO} out
        gpio -g mode ${UNLOCK_GPIO} out
        gpio -g write ${LOCK_GPIO} 0
        gpio -g write ${UNLOCK_GPIO} 0
        gpio export ${LOCK_GPIO} out
        gpio export ${UNLOCK_GPIO} out
        gpio exports
        echo Setup complete, no need to resetup unless gpio pins change
        # Above is same as:
        # echo ${LOCK_GPIO} > /sys/class/gpio/export
        # echo out > /sys/class/gpio/gpio${LOCK_GPIO}/direction
        # echo 0 > /sys/class/gpio/gpio${LOCK_GPIO}/value
        ;;

    lock | close | shut)
        # issue lock command
        # assume it was successful and report locked
        gpio -g write ${LOCK_GPIO} 1
        sleep ${SLEEP}
        gpio -g write ${LOCK_GPIO} 0

        echo LOCKED
        status=LOCKED
        ;;

    open | unlock)
        # issue unlock command
        # assume it was successful and report locked
        gpio -g write ${UNLOCK_GPIO} 1
        sleep ${SLEEP}
        gpio -g write ${UNLOCK_GPIO} 0

        echo UNLOCKED
        status=UNLOCKED
        ;;

    status | *)
        # issue status command
        # assume it was successful and report locked
        echo LOCKED
        ;;

esac

# Trigger 1.7.1 will show correct image assuming the above is clean
# debug or additional information can then be displayed below
# it shows up in a Toast style message
# Date/time is a useful addition
date
echo $USER@`uname -n`

