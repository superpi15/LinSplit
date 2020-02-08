#!/bin/bash 

HOME_DIR=`eval echo ~$USER`

# check gnome 
GCONFIG_DIR=$HOME_DIR/.gconf
GCONFTOOL=gconftool-2 
printf "Checking gnome ... "
if [ ! -d "$GCONFIG_DIR" ]
then
	echo "Cannot found gnome configuration folder."
	echo "Installation aborted."
	exit
fi
echo "PASS"

# check setting folder
#SETTING_DIR="$GCONFIG_DIR/desktop/gnome/keybindings"
#printf "Checking setting folder ... "
#if [ ! -d "$SETTING_DIR" ]
#then
#	echo "Cannot found gnome setting folder."
#	echo "Installation aborted."
#	exit
#fi
#echo "PASS"

# copy file
INSTALL_DIR=$HOME_DIR/.linsplit
mkdir -p $INSTALL_DIR
chmod +x app/screen.sh 
cp app/screen.sh $INSTALL_DIR/

# trace installed files
UNINS=$INSTALL_DIR/trace
touch $UNINS
echo $INSTALL_DIR/screen.sh >> $UNINS

# register key setting 
#fetchLegalName()
#{
#	for num in $(seq 0 2048)
#	do
#		if [ ! -d "$1/custom$num" ]
#		then
#			return $num
#		fi
#	done
#	return "-1"
#}

bindKeyOrien()
{
	ORIEN=$2
	NAME=$3
	KEY=$4
	$GCONFTOOL -s /desktop/gnome/keybindings/linsplit$1/binding --type=string "$KEY"
	$GCONFTOOL -s /desktop/gnome/keybindings/linsplit$1/name    --type=string "$NAME"
	$GCONFTOOL -s /desktop/gnome/keybindings/linsplit$1/action  --type=string "sh $INSTALL_DIR/screen.sh $ORIEN"
	#echo $INSTALL_DIR
	#fetchLegalName $SETTING_DIR
	#SID=$?
	#if [ "$SID" == "-1" ]
	#then
	#	echo "Setting pool is full"
	#	echo "Installation aborted"
	#	exit
	#fi
	#SDIR="$SETTING_DIR/custom$SID"
	#CONF="$SDIR/%gconf.xml"
	#echo $CONF
	#mkdir -p $SDIR
	#cp lib/keyconfig.template.xml $CONF
	#eval "sed -i 's/__TIME1__/$(date +%s)/g' $CONF"
	#eval "sed -i 's|__CMD__|sh $INSTALL_DIR/screen.sh $ORIEN|g' $CONF"
	#eval "sed -i 's/__TIME2__/$(date +%s)/g' $CONF"
	#eval "sed -i 's/__ACT__/$NAME/g' $CONF"
	#eval "sed -i 's/__TIME3__/$(date +%s)/g' $CONF"
	#eval "sed -i 's|__KEY__|$KEY|g' $CONF"
	
	#echo "$CONF"  >> $UNINS
	#echo "$SDIR"  >> $UNINS
}

echo "Registering configurations ... "
bindKeyOrien 0 u "Aligh-Up"       "<Ctrl><Alt>w"
bindKeyOrien 1 d "Aligh-Down"     "<Ctrl><Alt>x"
bindKeyOrien 2 l "Aligh-Left"     "<Ctrl><Alt>a"
bindKeyOrien 3 r "Aligh-Right"    "<Ctrl><Alt>d"
bindKeyOrien 4 a "Aligh-Central"  "<Ctrl><Alt>s"
echo "Installation terminated normally"

