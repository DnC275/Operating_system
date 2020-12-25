#!/bin/bash
echo $$ > .pid
mode=""
ans=1
usr1()
{
	mode="+"
}
usr2()
{
	mode="*"
}
term()
{
	mode="end"
}
trap 'usr1' USR1
trap 'usr2' USR2
trap 'term' SIGTERM
while true; do
	case $mode in
		"+")
			let ans=$ans+2
			echo "ans=$ans"
			mode=""
			;;
		"*")
			let ans=$ans*2
			echo "ans=$ans"
			mode=""
			;;
		"end")
			killall task6_generator
			echo "Script stopped by the signal"
			exit
			;;
		*)
			echo "ans=$ans"
			;;
	esac
	sleep 1s
done
