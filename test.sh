#!/bin/sh
#echo '{ "version": 1 }'

#echo '['

#echo '[],'
PRE='{ "full_text": "'
COL='", "color": "'
CER='" }'
NORMCOL='#ffffff'

ram_usage=`ruby ./ram.rb`
	
	if [ $ram_usage -ge 90 ]; then
	#türkis
	color="33ffee"
	else
		if [ $ram_usage -ge 50 ]; then
		#lightblue
		color="3399ee"
		else
		#blue
		color="#0000ff"
		fi
	fi
	RAM=$PRE$ram_usage"%"$COL$color$CER
echo $ram_usage
