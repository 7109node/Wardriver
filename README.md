Wardriver
=========

Automates wardriving and the creation of KML overalys from collected data.

=======

This script will create a "kismet_logs" directory in the /root directory.  From here you can select .netxml files to parse
into the sqlite.db.  The db will continue to grow without duplicate entries as you contine to use this script.  The entire
premise is that based off the functionality of Kismet for data collection and giskismet for data parsing.

=======

For best results place the wardriver.sh into the /usr/local/bin directory and set as executable.  from that point you
may call the script from the command line with "wardriver".


