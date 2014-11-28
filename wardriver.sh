#!/bin/bash

#title           :wardriver.sh
#description     :The wardriver script is designed to make wardriving more efficient.  This will utilize giskismet and kismet to create kml overlays.
#author		 :Seth Bare
#date            :20141110
#version         :0.3   
#usage		 :Place in /usr/local/bin set to executable.  Call from a terminal with ./wardriver.sh
#notes           :Edit your Kismet.conf to reflect the directory ~/kismet_logs
#bash_version    :4.1.5(1)-release
#Licensing	 Licensed under the GNU GPL V 3.0
#******************* Note you Must change the Kismet_logs variable to reflect the directory your kismet logs are stored in.******************  

############ Variables ####################

RED=$(tput setaf 1 && tput bold)
GREEN=$(tput setaf 2 && tput bold)
STAND=$(tput sgr0)
BLUE=$(tput setaf 6 && tput bold)
Kismet_Logs="$(find /root/kismet_logs -name '*.netxml' )"

############## Begin script loop ########################

while :
do

############## Main Menu ####################
 
clear
echo $RED"#########################################"
echo "#   $STAND         The Wardriver              $RED#"
echo "#########################################"
echo "#                                       #"
echo "#$GREEN [1]$BLUE Begin Wardriving                  $RED#"
echo "#$GREEN [2]$BLUE Process a Wardrive                $RED#"
echo "#$GREEN [3]$BLUE Create a KML overlay $RED             #"
echo "#$GREEN [4]$BLUE Quit        $RED                      #"
echo "#                                       #"
echo "#########################################"
echo ""
echo ""
read -p $GREEN"Please choose an option?$STAND: " ChosenOption
echo 
case $ChosenOption in

############## Begin [1]:  Begin Wardriving ################
1)

clear
read -p $GREEN"Press [Enter] to launch the Kismet.$STAND"

xterm -geometry 111x24+650+0 -e kismet

echo ""
echo $RED"Please wait..."$STAND
sleep 1
echo ""  
;;

##########  End [1]:  Begin Wardriving ######################

########## Begin [2]: Process a Wardrive ####################
2)

clear

echo $RED"Available Wardrive Files."
echo "########################"$STAND
echo ""
echo "$Kismet_Logs"
echo ""
read -p $GREEN"Please copy and paste the wardrive file from above you wish to process:" selected_file
cd /root/kismet_logs
xterm -geometry 111x24+650+0 -e giskismet -x $selected_file
echo ""
echo "Please wait"
sleep 1
echo ""
;;
############### End [2]:  Process a Wardrive #################

############### Begin [3]:  Create a KML Overlay ###################
3)
clear
echo "Create a KML overlay from your Wirelss Database."
echo ""
echo $GREEN"[1]$BLUE = All Wifi Networks."
echo $GREEN"[2]$BLUE = All Open Networks."
echo $GREEN"[3]$BLUE = All WEP Networks."
echo $GREEN"[4]$BLUE = All WPA Networks."
echo $GREEN"[5]$BLUE = A Specific Network Name."
echo $GREEN"[6]$BLUE = Return to Main Menu."
read -p $GREEN" Select an option 1-6?:$STAND " option

############# Start Option 1 ######################

if [[ $option == "1" ]]; then
   read -p "What would you like to name this KML?" all_net
   cd /root/kismet_logs
   giskismet -q "select * from wireless" -o $all_net.kml 
   echo $RED"Press enter to continue"
   read x
fi
########## End Option 1 ########################

########## Start Option 2 ######################
if [[ $option == "2" ]]; then
   read -p "What would you like to name this KML?" open_net
   cd /root/kismet_logs 
   giskismet -q "select * from wireless where Encryption='None'" -o $open_net.kml
   echo $RED"Press enter to continue"
   read x
fi
######## End Option 2 #########################

######## Start Option 3 #######################

if [[ $option == "3" ]]; then
   read -p "What would you like to name this KML?" wep_net
   cd /root/kismet_logs   
   giskismet -q "select * from wireless where Encryption='WEP'" -o $wep_net.kml
   echo $RED"Press enter to continue"
   read x
fi
######## End Option 3 #########################

######## Start Option 4 ##################################

if [[ $option == "4" ]]; then
   read -p "What would you like to name this KML?" wpa_net
   cd /root/kismet_logs
   giskismet -q "select * from wireless where Encryption='WPA+PSK WPA+AES-CCM'" -o "$wpa_net"_PSK.kml 
   giskismet -q "select * from wireless where Encryption='WPA+TKIP WPA+PSK WPA+AES-CCM'" -o "$wpa_net"_TKIP.kml
   mkdir /root/kismet_logs/"$wpa_net"
   mv /root/kismet_logs/"$wpa_net"_PSK.kml /root/kismet_logs/"$wpa_net"
   mv /root/kismet_logs/"$wpa_net"_TKIP.kml /root/kismet_logs/"$wpa_net"
   echo $RED"Press enter to continue"
   read x
fi
######## End Option 4 #####################################
######## Start Option 5 ###################################

if [[ $option == "5" ]]; then
   read -p "What would you like to name this KML?" name_net
   read -p "What is the name of the network you wish to map?" MAC
   cd /root/kismet_logs
   giskismet -q "select * from wireless where ESSID='$MAC'" -o $name_net.kml
   echo $RED"Press enter to continue"
   read x
fi
######### End option 5 ###########################

######### Start Option 6 #########################
;;
######### End Option 6 ###########################

############# Start:  Selection 4 "quit"  ###############################################################

4)
clear
echo $RED"Closing the program."
sleep 5
exit
;;
############ End:  Selection 4 "quit" ###################################################################
esac
done


