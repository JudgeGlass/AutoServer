#!/bin/bash
#!/bin/sh

settings=server.properties

settings(){
	if [ ! -f $settings ]; then
		whiptail --title "Settings" --msgbox "Please start the server to make setting file." 8 78
	fi

	while [ 1 ]
	do
	CHOICE=$(
	whiptail --title "Settings" --menu "Server settings" --nocancel 16 100 9 \
		"Port" "Default: 25565" \
		"Veiw-Distance" "Default: 10" \
		"Mobs" "Default: true" \
		"Ram" "Default: 1GB" \
		"Back" "Back to main menu" 3>&2 2>&1 1>&3
	)

	case $CHOICE in
		"Port")
			PORT=$(whiptail --inputbox "Enter a valid port number" 8 78 25565 --title "Port" 3>&1 1>&2 2>&3)
			exitstatus=$?
			if [ $exitstatus = 0 ]; then
				$PORT
			fi
			sed -i -e "s/\(server-port=\).*/\1$PORT/" $settings
	;;
		"Veiw-Distance")
                        VIEW=$(whiptail --inputbox "Enter desired view distance" 8 78 10 --title "View-Distance" 3>&1 1>&2 2>&3)
                        exitstatus=$?
                        if [ $exitstatus = 0 ]; then
                                $VEIW
                        fi
                        sed -i -e "s/\(view-distance=\).*/\1$VIEW/" $settings

	;;
		"Mobs")
			MOBS=$(whiptail --inputbox "Enable or disable mobs(true/false)?" 8 78 25565 --title "Enable mobs" 3>&1 1>&2 2>&3)
                        exitstatus=$?
                        if [ $exitstatus = 0 ]; then
                                $MOBS
                        fi
                        sed -i -e "s/\(spawn-monsters=\).*/\1$MOBS/" $settings
	;;
		"Ram")
			RAM=$(whiptail --inputbox "How much ram?(ex: 1,2,3,4,5) NOTE: takes effect after restarting program" 8 78 1 --title "Ram" 3>&1 1>&2 2>&3)
                        exitstatus=$?
                        if [ $exitstatus = 0 ]; then
                                $RAM
                        fi
                        sed -i -e "s/\(RAM=\).*/\1$RAM/" Config.conf
	;;
		"Back")
			break
	;;
	esac
	done
}

settings
