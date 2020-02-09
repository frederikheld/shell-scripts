status=`cat /etc/cntlm.conf | grep NoProxy | grep -n "#NoProxy" | cut -c1`
if test "$status" -eq 1; then
   echo "Free Internet"
elif test "$status" -eq 2; then
   echo "BCN"
else
   echo "CNTLM settings are corrupted :-( Please check /etc/cntlm.conf manually!"
fi

