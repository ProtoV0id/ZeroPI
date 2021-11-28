#!/bin/bash
##########################
# PROTOVOID              #
# IG @protov0id          #
# Updated: 11/27/2021    #
##########################
clear
echo "  ______               _______  _              _____              _         _   ";
echo " |___  /              |__   __|(_)            / ____|            (_)       | |  ";
echo "    / /  ___  _ __  ___  | |    _   ___  _ __| (___    ___  _ __  _  _ __  | |_ ";
echo "   / /  / _ \| '__|/ _ \ | |   | | / _ \| '__|\___ \  / __|| '__|| || '_ \ | __|";
echo "  / /__|  __/| |  | (_) || |   | ||  __/| |   ____) || (__ | |   | || |_) || |_ ";
echo " /_____|\___||_|   \___/ |_|   |_| \___||_|  |_____/  \___||_|   |_|| .__/  \__|";
echo "                                                                    | |         ";
echo "                                                                    |_|         ";
echo                           ----------------------------
echo                           ZeroTierScript by PROTOVOID
echo                             ZeroTier version 1.8.3
echo                           ----------------------------
sleep 1.5
#Variables and Misc Stuff
D=$(pwd) #stores the pwd in a variable to be called later. This part gave me propblems and can propbably be updated.
FILE="zerotier-one_1.8.3_armhf.deb"
# FILE is the most updated version. This is the only variable that should need updating in the future.
# NETID: ZeroTier network ID needed for loggin in. Not saved or sent anywhere.

#Checking to see if they want to run. Will need to work on a function or python version for a full program version. If you want to help contact me on instagram @protov0id

echo "This is for a first time install or update only. If you already have the most up to date version downloaded. Please check the README for further instructions."
read -p "Do you wish to continue? Y/N " ANSWER1
case $ANSWER1 in
  [yY] | [yY][eE][sS] )
  echo "Checking to see if ZeroTier is already installed..."
  sleep 1.5
    ;;
    [nN] | [nN][oO] )
    echo "Goodbye."
    exit
esac

#First see if ZeroTier is already installed
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

    #Same thing happens as yes, but with the new network id
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
