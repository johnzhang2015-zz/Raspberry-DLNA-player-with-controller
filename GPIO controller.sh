#!/bin/bash

#echo "8" > /sys/class/gpio/export
#echo "out" > /sys/class/gpio/gpio8/direction

#GPIO8=$(cat /sys/class/gpio/gpio8/value)
#status=$(cat /proc/asound/card*/pcm*/sub*/status)
while :
#如何实现读取不到GPIO值时写入GPIO初始值，否者不写入
do

	GPIO8=$(cat /sys/class/gpio/gpio8/value)
	echo $GPIO8

	if [ $GPIO8 -eq 1 ];then
	
	echo "8" > /sys/class/gpio/export
	echo "out" > /sys/class/gpio/gpio8/direction

	fi
done



#cat > GPIO8 /sys/class/gpio/gpio8/value
echo $GPIO8
#cat /sys/class/gpio/gpio8/value - status
echo $status

# Recommend syntax for setting an infinite while loop

while : 

do
	sleep 5s

	GPIO8=$(cat /sys/class/gpio/gpio8/value)
	echo $GPIO8

	if [ $GPIO8 -eq 0 ];then



		if cat /proc/asound/card*/pcm*/sub*/status | grep -q RUNNING; then
 			echo 'do nothing, keep playing'
			sleep 5s
		else
			sleep 5s
			echo "1" > /sys/class/gpio/gpio8/value #amplifier  poweroff
			sleep 5s
			echo "1" > /sys/class/gpio/gpio7/value #DAC poweroff
		fi


	else

		if cat /proc/asound/card*/pcm*/sub*/status | grep -q RUNNING; then

		
		# power on system when system detect playing and it is not power on.
		#echo "8" > /sys/class/gpio/export
		#echo "out" > /sys/class/gpio/gpio8/direction
		echo "0" > /sys/class/gpio/gpio7/value #amplifier  poweron
		sleep 5
		echo "0" > /sys/class/gpio/gpio8/value	#DAC poweron
		echo 'poweron amplifier'
		sleep 5s	
		

		#else 
	
		# delay 30 minutes to power off system when playing stop
		#sleep 5s
		
		# power off system.
		#echo "8" > /sys/class/gpio/expor
		#echo "out" > /sys/class/gpio/gpio8/direction
		#echo "1" > /sys/class/gpio/gpio8/value
		#echo 'poweroff amplifier'
	
		# delay 1 minute for a loop, no need to handle so speed.

		#sleep 2s
		
		fi
	fi

done
