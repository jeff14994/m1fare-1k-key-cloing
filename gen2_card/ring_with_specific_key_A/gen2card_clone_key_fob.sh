#!/bin/bash

#source mockup # library with function to work with lines
input="./parse_dump"
input1="./parsed_keys"
count=0
countA=0
while read lineA
do
    countB=0
    while read lineB
    do
    	if [ "$countA" -eq "$countB" ]
        then
			# main function
			command="hf mf wrbl --blk $count -k $lineB -d $lineA;"
    		# write from pm3 to device
    		echo $command | pm3
    		#echo $command
    		sleep 1
            echo "$lineA" "$lineB"
			count=$((count+1))
            break
        fi
        countB=`expr $countB + 1`
        done < parsed_keys
     countA=`expr $countA + 1`
done < parse_dump
