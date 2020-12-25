#!/bin/bash
ans=1
mode="+"
(tail -f pipe) |\
while true; do
	read line
	case $line in
		"+")
			mode="+"
			;;
		"*")
			mode="*"
			;;
		"QUIT")
			killall task5_generator
			tail_pid=$(ps --ppid $$ o pid,ppid,cmd | grep -E "tail -f" |\
grep -Eo "^[[:space:]]*[0-9]+")
			kill $tail_pid
			echo -e "End\nans=$ans"
			exit
			;;
		*)
			tmp=$(echo "$line" | grep -E '^[0-9]+$')
			if [[ -n $tmp ]]; then
				case $mode in
					"+")
						let ans=$ans+$tmp
						;;
					"*")
						let ans=$ans*$tmp
						;;
				esac
			else
				killall task5_generator
				killall tail
				echo -e "End\nIncorrect input data"
				exit
			fi
			;;
	esac
done
