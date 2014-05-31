#!/bin/sh
#\e[COLORm text \e[COLORm --> colored text

echo '{ "version": 1 }'

echo '['

echo '[],'
PRE='{ "full_text": "'
COL='", "color": "'
CER='" }'
NORMCOL='#ffffff'

while [ 1 -gt 0 ]
do
	is_charged=`acpi -b | grep "remaining"`
	output=""

	# Battery status
	#double quotes --> see v1
	if [ "$is_charged" = "" ]; then
		#charging green
		color="#00ff00"
	else
		#uncharging
		if [ "`acpi -b | cut -d "," -f 2 | cut -d "%" -f 1 | cut -d " " -f 2`" -lt 10 ]; then 
		#below 10% red
		color="#ff0000"
		else
		#blue
		color="#0000ff"
		fi
	fi
	BATERIA=$PRE"`acpi -b | cut -d "," -f 2 | cut -d " " -f 2`"$COL$color$CER
	#time remaining
	TIME=$PRE"`acpi -b | cut -d "," -f 3 | cut -d " " -f 2`"$COL$NORMCOL$CER
	#date
	DATE=$PRE"`date | cut -d " " -f 1-4`"$COL$NORMCOL$CER
	WLAN=$PRE"`iwgetid -r`"$COL$NORMCOL$CER
	#RAM
	ram_usage=`ruby ~/.i3/ram.rb`
	if [ "$ram_usage" = "" ]; then
	ram_usage="no"
	fi
	check=${ram_usage%.*}
	#check=51
	if [ $check -ge 90 ]; then
	#türkis
	color="#33ffee"
	else
		if [ $check -ge 50 ]; then
		#lightblue
		color="#3399ee"
		else
		#blue
		color="#0000ff"
		fi
	fi
	RAM=$PRE"$ram_usage%"$COL$color$CER
	
	echo "[$DATE,$WLAN,$RAM,$BATERIA,$TIME]," || exit 1
	sleep 5
done

#v1:
#If $is_charged is a string containing spaces or other special characters, and single square brackets are used (which is a shortcut for the test command), then the string may be split out into multiple words. Each of these is treated as a separate argument.
#So, one variable becomes split into many arguments.
#The same will be true for any function call that puts down a string containing spaces or other special characters.



