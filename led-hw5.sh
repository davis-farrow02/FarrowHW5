#!/bin/bash
# A small Bash script to set up User LED3 to be turned on, off and blinked  from 
#  Linux console. Written by Derek Molloy (derekmolloy.ie) and modified by Davis Farrow
#  for the book Exploring BeagleBone.
#  Modification for CPE422 Assignment 5 problem 1. Takes 2 user arguments and blinks
#  LED3 as many times as number user enters.

LED3_PATH=/sys/class/leds/beaglebone:green:usr3

# initialize counter
counter=0

# Example bash function
function removeTrigger
{
  echo "none" >> "$LED3_PATH/trigger"
}

echo "Starting the LED Bash Script"
if [ $# -eq 0 ]; then
  echo "There are no arguments. Usage is:"
  echo -e " bashLED Command \n  where command is one of "
  echo -e "   on, off, flash or status  \n e.g. bashLED on "
  exit 2
fi
echo "The LED Command that was passed is: $1"
if [ "$1" == "on" ]; then
  echo "Turning the LED on"
  removeTrigger
  echo "1" >> "$LED3_PATH/brightness"
elif [ "$1" == "off" ]; then
  echo "Turning the LED off"
  removeTrigger
  echo "0" >> "$LED3_PATH/brightness"
elif [ "$1" == "flash" ]; then
  echo "Flashing the LED"
  removeTrigger
  echo "timer" >> "$LED3_PATH/trigger"
  sleep 1
  echo "100" >> "$LED3_PATH/delay_off"
  echo "100" >> "$LED3_PATH/delay_on"
elif [ "$1" == "status" ]; then
  cat "$LED3_PATH/trigger";
elif [ "$1" == "blink" ]; then
	echo "blinking the LED $2 times"
	removeTrigger
	while [ $counter -lt $2 ]; do
		echo "1" >> "$LED3_PATH/brightness"
		sleep 1 #LED on for 1 second
		echo "0" >> "$LED3_PATH/brightness"
		sleep 1 #LED off for 1 second
		((counter++))
	done
fi
echo "End of the LED Bash Script"
