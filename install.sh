#!/bin/bash
basewebsite="https://raw.githubusercontent.com/swgamez/THera/main/install.sh"
sleep 2s
#Step 1) Check if root--------------------------------------
if [[ $EUID -ne 0 ]]; then
   echo "Please execute script as root." 
   exit 1
fi

#-----------------------------------------------------------

#Step 3) Update repository----------------------------------
sudo apt-get update -y

sleep 2s
#-----------------------------------------------------------

#Step 4) Install gpiozero module----------------------------
sudo apt-get install -y python3-gpiozero

sleep 2s
#-----------------------------------------------------------

#Step 5) Download Python script-----------------------------
cd /userdata/
mkdir RetroFlag
cd RetroFlag
script=SafeShutdown.py
wget --no-check-certificate "$basewebsite/main/SafeShutdown.py"
chmod +x SafeShutdown.py
wget --no-check-certificate "$basewebsitemain/multi_switch.sh"
chmod +x multi_switch.sh

#-----------------------------------------------------------
sleep 2s
#Step 6) Enable Python script to run on start up------------
cd /userdata/RetroFlag/
RC=rc.local

if grep -q "sudo python3 \/userdata/RetroFlag/SafeShutdown.py \&" "$RC";
	then
		echo "File/userdata/RetroFlag/rc.local already configured. Doing nothing."
	else
		sed -i -e "s/^exit 0/sudo python3 \/userdata/RetroFlag/SafeShutdown.py \&\n&/g" "$RC"
		echo "File /userdata/RetroFlag/rc.local configured."
fi
#-----------------------------------------------------------

#Step 7) Reboot to apply changes----------------------------
echo "RetroFlag Pi Case installation done. Will now reboot after 3 seconds."
sleep 3s
sudo reboot
#-----------------------------------------------------------

