#!/bin/bash

driver_path=/Library/Printers/PPDs/Contents/Resources/KONICAMINOLTA364e.gz
printer_name="TUe"
printer_location="TUe"

clear

echo 'Little script for installing Konica Minolta 364e printers @ TUe'
echo 'by M.H. Wetzels (ID)'
echo 'and C. Huizing (W&I) for configuration file'
echo '==============================================================='
echo 'Checking for previously installed drivers'
if [ -e $driver_path ]; then
        osascript -e 'display notification "Drivers already installed" with title "Install TUe Printer"'
        echo 'Drivers are already installed at' $driver_path
else
	echo 'Drivers not found, moving bundled version. (requires password)'
	sudo cp ./KONICAMINOLTA364e.gz $driver_path
	echo 'Drivers installed'
        osascript -e 'display notification "Installed drivers" with title "Install TUe Printer"'
fi

echo 'Creating printer with lpadmin...'
if lpadmin -p $printer_name -L $printer_location -P ./tfy.ppd -E -v smb://tueprint.campus.tue.nl/MFP-CAMPUS-PS -P $driver_path; then
        osascript -e 'display notification "Installed Konica Minolta 364e" with title "Install TUe Printer"'
	echo 'Printer created, happy printing'
else
	echo 'Printer not created, see http://www.win.tue.nl/~keesh/dokuwiki/doku.php?id=mac_wiki:printing_with_the_konica_minoltas for manual installation'
        osascript -e 'display notification "Failed to install Konica Minolta 364e" with title "Install TUe Printer"'
        exit 1
fi

echo -n -e "\033]0;Install Window\007"

echo 'Closing window...'
osascript -e 'display notification "Happy printing!" with title "Install TUe Printer"'

sleep 5s 
osascript -e 'tell application "Terminal" to close (every window whose name contains "Install Window")' &

exit 0
