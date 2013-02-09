#!/bin/bash

P_HOSTNAME=$1
P_IPADDRESS=$2
P_DOMAIN=$3
P_MACADDRESS="00:00:00:00:00:00"
/bin/echo ${P_HOSTNAME} ${P_IPADDRESS} ${P_MACADDRESS} ${P_DOMAIN} | `which netcat` dns-1.london.tomoconnor.eu 9999
