#!/bin/bash

trim() { echo $1; }

ALLOWED_OFFSET=120 #the slave can be upto 120s behind the master?

DB_TIMESTAMP=$(trim $(psql root -t -c "select timestamp from lag"))
NOW=$(trim $(date +%s))

#echo $DB_TIMESTAMP
#echo $NOW

OFFSET=$(($NOW - $DB_TIMESTAMP))
ABSOLUTE_OFFSET=$(echo $OFFSET|nawk '{ print ($1 >= 0) ? $1 : 0 - $1}')

if [ $ABSOLUTE_OFFSET -gt $ALLOWED_OFFSET ]
	then
		echo "We've got a problem here with Postgresql replication lag on $HOSTNAME. Lag is $ABSOLUTE_OFFSET seconds"| logger -p local0.error -t ${0##\*/}[$$]

	else
		echo "Replication OK - $ABSOLUTE_OFFSET seconds behind" | logger -p local0.info -t ${0##\*/}[$$]
fi

