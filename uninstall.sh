#!/bin/bash 

# find installed path 

HOME_DIR=`eval echo ~$USER`
INSTALL_DIR=$HOME_DIR/.linsplit
TRACE=$INSTALL_DIR/trace
if [ ! -f "$TRACE" ]
then
	echo "Cannot find installation log"
	echo "Uninstallation aborted"
	exit
fi

for file in $(cat $TRACE)
do
	if [ ! -e "$file" ]
	then
		continue
	fi
	echo $file
	rm -rf $file
done
rm -rf $INSTALL_DIR
echo "Uninstallation terminated normally"
