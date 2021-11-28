#!/bin/bash
##########################
# PROTOVOID              #
# IG @protov0id          #
# Updated: 11/27/2021    #
##########################
clear
echo ----------------------------
echo ZeroTierScript by PROTOVOID
echo ZeroTier version 1.8.3
echo ----------------------------
sleep 1.5
#Variables and Misc Stuff
D=$(pwd)
# FILE is the most updated version. This is the only variable that should need updating in the future.
# NETID: ZeroTier network ID needed for loggin in. Not saved or sent anywhere.

#First see if ZeroTier is already installed
FILE="zerotier-one_1.8.3_armhf.deb"
if [ -f "$FILE" ]
then
  echo "Zerotier is already installed and is the most recent verision."
  echo "Follow my instagram @protov0id for updates to this script!"
  sleep 1.5
  exit
else
  echo "$FILE does not appear to be on this machine. The installation process will continue."
fi
#Get their network ID for later portion
read -p "what is your ZeroTier Network ID? " NETID

#Check for gdebi (Needed for propper install)
sleep 1.5
echo "Checking for neccessary program..."
sleep 1.5
command -v gdebi >/dev/null 2>&1 || { echo >&2 "I require gdebi but it's not installed."; read -p "Press ENTER to install gdebi."; }
#sudo apt install gdebi -y

#Download most recent ZeroTier Version
sleep 1.5
echo "Downloading most recent Zerotier version..."
sleep 1.5
#wget https://download.zerotier.com/RELEASES/1.8.3/dist/debian/buster/"$FILE"
echo "Installing Zerotier..."
sleep 1.5
sudo $(gdebi "$D/$FILE")

#Zerotier should be installed now to check it.
sleep 1.5
echo "Checking status..."
if $(sudo zerotier-cli status) | grep -q 'ONLINE'; then
  echo "You're connected!"
else
  echo "Error. Please consult the Zerotier Website. If it is a distribution error, check the README."
  sleep 1.5
  #exit
fi
#Have them double check their network ID
echo "It's time to join your network. You entered $NETID as your Network ID"
read -p "Is this your correct Network ID? Press Y to continue or press N to change it." ANSWER
case "$ANSWER" in
  [yY] | [yY][eE][sS])
    $(sudo zerotier-cli join $NETID)
    if $(sudo zerotier-cli status) | grep -q 'ONLINE'; then
      echo "You're connected!"
    else
      echo "Error. Please consult the Zerotier Website and make sure you've connected the device on the website. If it is a distribution error, check the README."
      sleep 1.5
      #exit
    fi
    ;;
    [nN] | [nN][oO])
    read -p "Please enter your Network ID from Zerotier." NETID2
    $(sudo zerotier-cli join $NETID2)
    #
    if $(sudo zerotier-cli status) | grep -q 'ONLINE'; then
      echo "You're connected!"
      $(sudo update-rc.d zerotier-one enable)
      echo "You're all done! Please let me know what you though of the process. For updates follow my instagram @protov0id."
    else
      echo "Error. Please consult the Zerotier Website and make sure you've connected the device on the website. If it is a distribution error, check the README."
      sleep 1.5
      #exit
    fi
    ;;
    * )
   echo "You didn't follow directions. Time to restart, should be quicker this time. Make sure to just press Y or N next time."
esac

#END OF PROGRAM
#MAKE SURE TO COMMENT YOUR CODE.
