#!/bin/bash
input="./parse_dump"
count=0
command=""
result=""
while IFS= read -r line
do
	# concatanate the commands 
	# format  hf mf wrbl --blk ${0} -k FFFFFFFFFFFF -d ${1};
	# assign data to each block
	command="hf mf wrbl --blk $count -k FFFFFFFFFFFF -d $line;" 
	# write from pm3 to device
	echo $command | pm3
	#echo $command
	sleep 1
	#result+="$command" 
	# update block
	count=$((count+1))
  echo "$count"
  #echo $command
done < "$input"
echo "Gen2 key fob: New key fob created... Go and Try!"

