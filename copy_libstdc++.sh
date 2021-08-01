# !/bin/bash 

#read ip or you can use a default value for a variable like so
ip=${1:-192.168.1.100}

#check the connectivity of the board
if ping -q -c 1 -W 1 $ip >/dev/null; then
  	echo "IPv4 is up"
	# do the Copy
	scp -Cr libstdc++.so.6 root@$ip:/usr/lib && echo Successful Coping!
else
  	echo "IPv4 is down"
fi


