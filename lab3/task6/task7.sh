#!/bin/bash
>trash
pid=$(top -b -n1 o TIME+ | grep "my_proc" | head -n1 | awk '{print $1}')
(while true
do
	tmp=$(top -b -n1 o TIME+ | grep -E "^[[:space:]]*$pid[[:space:]]")
	cpu=$(echo $tmp | awk '{print $9}')
	echo "$tmp" >> trash
	ni=$(echo $tmp | awk '{print $4}')
	if (( $(echo "$cpu > 10" | bc) )); then
		let ni=$ni+1
		renice -n $ni -p $pid 1>/dev/null
	fi
done 2>/dev/null) &
