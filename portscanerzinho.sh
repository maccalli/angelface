#!/bin/bash
if [ "$1" == "" ]
then 
	echo "EAE RAPARIGO"
	echo "Modo de uso $0 REDE"
	echo "Exemplo: $0 172.16.1"
else 
for ip in {1..254};
do 
hping3 -S -p 80 -c 1 $1.$ip 2> /dev/null | grep "SA" | cut -d " " -f 2 | cut -d "=" -f 2;


done 
fi

