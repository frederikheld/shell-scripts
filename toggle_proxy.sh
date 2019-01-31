#!/bin/sh

# Purpose:	Toggle proxy in CNTLM configuration to switch
#		between networks with and without company proxy.
#
# Author:	Frederik S. Held (kontakt@frederikheld.de)
# Date:		2019-01-31
#
# Description:
#
# This script can be used to toggle between two NoProxy configurations in cntlm.
# This is usually needed if you switch between networks behind a company proxy
# and networks with free internet access.
#
# You can configure two different configurations for NoProxy in /etc/cntlm.conf
# and comment out the one you don't want to use right now.
#
# Example:
#
#	NoProxy		localhost, 127.0.0.*, 10.*, 192.168.*	# behind company proxy
#	#NoProxy	*					# free internet access
#
# The script will move the pound sign from one of those lines to the others and
# then restart the cntlm service to bring the new configuration in effect.
#
# Usage:
#
#	$ sudo sh toggle_cntlm.sh
#
# Tested with Ubuntu 18.10 and cntlm 0.92.3-1ubun am64

cntlm_config_path='/etc/cntlm.conf'

echo 'Toggleing proxy configuration...'
sed -i.bak '/^NoProxy/ s/^/~/' "$cntlm_config_path"	#  NoProxy --> ~NoProxy
sed -i '/^#NoProxy/ s/^.//' "$cntlm_config_path"	# #NoProxy -->  NoProxy
sed -i '/^~NoProxy/ s/^./#/' "$cntlm_config_path"	# ~Noproxy --> #NoProxy

echo 'Restarting cntlm service...'
sudo service cntlm restart

echo 'Done.'
