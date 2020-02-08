CMD=$1
if [ "$1" == "" ]
then
	exit
fi

RES=`xrandr | grep -w connected | awk -F'[ +]' '{print $3}'| sed 's/x/ /g'`
W=`echo ${RES} | awk '{print $1}' `
H=`echo ${RES} | awk '{print $2}' `
echo "Resolution $W $H"

WID=`xdotool getactivewindow`
echo "Windoe ID $WID"

POS=`xwininfo -id $WID | grep Absolute`
X=`echo $POS | grep X | awk '{print $4}'`
Y=`echo $POS | grep Y | awk '{print $8}'`
echo "Current position=$X $Y"

HalfW=`expr $W / 2`
HalfH=`expr $H / 2`
echo "HalfW=$HalfW HalfH=$HalfH"
windowAdj()
{
	echo $*
	xdotool windowsize $1 $4 $5
	xdotool windowmove $1 $2 $3
}
echo "switch"
case "$1" in
	l) windowAdj $WID      0      0 $HalfW      $H
		;;
	r) windowAdj $WID $HalfW      0 $HalfW      $H
		;;
	d) windowAdj $WID      0 $HalfH     $W  $HalfH
		;;
	u) windowAdj $WID      0      0     $W  $HalfH
		;;
	a) windowAdj $WID      0      0     $W      $H
		;;
esac

