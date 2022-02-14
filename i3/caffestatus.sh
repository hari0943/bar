status=`xset -q | grep 'DPMS is' | awk '{ print $3 }'`
if [ $status == 'Enabled' ]; then
	echo "☕"
else
	echo ""
fi
