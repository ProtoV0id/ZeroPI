#!/bin/bash
##########################
# PROTOVOID              #
# IG @protov0id          #
# Updated: 3/26/2022     #
##########################
clear
echo "  ______                  _____  _____ ";
echo " |___  /                 |  __ \|_   _|";
echo "    / /  ___  _ __  ___  | |__) | | |  ";
echo "   / /  / _ \| '__|/ _ \ |  ___/  | |  ";
echo "  / /__|  __/| |  | (_) || |     _| |_ ";
echo " /_____|\___||_|   \___/ |_|    |_____|";
echo "                                       ";
echo "                                       ";
echo                           ----------------------------
echo                           ZeroPI by PROTOVOID
echo                             ZeroTier version 1.8.3
echo                           ----------------------------
sleep 1.5
#LOTS OF RANDOM AND COMMENTED OUT CODE. MY FULL IDEA HASN'T WORKED YET. UPDATES WILL OCCUR.
#Variables and Misc Stuff
D=$(pwd) #stores the pwd in a variable to be called later. This part gave me propblems and can propbably be updated.
#CHK=$(dpkg -s zerotier-one) | grep -q "1.8.3" #checks to see if this is the most up to date file
FILE="zerotier-one_1.8.3_armhf.deb"

# FILE is the most updated version. This is the only variable that should need updating in the future.
# NETID: ZeroTier network ID needed for login. Not saved or sent anywhere.

#Checking to see if they want to run.
#Will need to work on a function or python version for a full program version. If you want to help contact me on instagram @protov0id
#####################################################################################
echo "Welcome to ZeroPI! This script will check for/install the most up to date ZeroTier installation."
echo "Before starting, please make sure you have created a ZeroTier account and have your NetworkID handy."
read -p "When ready, press enter to continue."
sleep 1.5
#####################################################################################
#First see if ZeroTier is already installed
if [ $(dpkg -s zerotier-one) | grep -q "1.8.3" ]
then
  echo "Zerotier is already installed and is the most recent verision."
  echo "Follow my instagram @protov0id for updates to this script!"
  sleep 1.5
  exit
else
  echo "Zerotier does not appear to be installed or is out of date. Installation will continue..."
fi

#####################################################################################
#In the case of ZT already being installed, we will remove the package
# $(sudo apt remove zerotier-one -y && sudo apt purge zerotier-one -y)
# $(sudo apt autoremove)
#####################################################################################
#Get their network ID for later portion
read -p "what is your ZeroTier Network ID? " NETID

#####################################################################################
# #Check for gdebi (Needed for propper install)
# sleep 1.5
# echo "Checking for neccessary program..."
# sleep 1.5
# command -v gdebi >/dev/null 2>&1 || { echo >&2 "I require gdebi but it's not installed."; read -p "Press ENTER to install gdebi."; }
# sudo apt install gdebi -y
#####################################################################################
#Download most recent ZeroTier Version
sleep 1.5
echo "Downloading most recent Zerotier version..."
sleep 1.5
wget https://download.zerotier.com/RELEASES/1.8.3/dist/debian/buster/"$FILE"
echo "Installing Zerotier..."
sleep 1.5
sudo $(dpkg -i "$D/$FILE")
#####################################################################################
#Zerotier should be installed now to check it.
sleep 1.5
echo "Checking status..."
if $(sudo zerotier-cli status) | grep -q 'ONLINE'; then
  echo "You're connected!"
else
  echo "Error. Please consult the Zerotier Website. If it is a distribution error, check the README."
  sleep 1.5
  exit
fi
#####################################################################################
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
      exit
    fi
    ;;
    [nN] | [nN][oO])
    read -p "Please enter your Network ID from Zerotier." NETID2
    $(sudo zerotier-cli join $NETID2)

    #Same thing happens as yes, but with the new network id
    if $(sudo zerotier-cli status) | grep -q 'ONLINE'; then
      echo "You're connected!"
      $(sudo update-rc.d zerotier-one enable)
      echo "You're all done! Please let me know what you though of the process. For updates follow my Instagram @protov0id."
    else
      echo "Error. Please consult the Zerotier Website and make sure you've connected the device on the website. If it is a distribution error, check the README."
      sleep 1.5
      exit
    fi
    ;;
    * )
   echo "You didn't follow directions. Time to restart, should be quicker this time. Make sure to just press Y or N next time."
esac

#END OF PROGRAM
#MAKE SURE TO COMMENT YOUR CODE.
