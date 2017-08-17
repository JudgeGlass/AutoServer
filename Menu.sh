#!/bin/bash
#!/bin/sh

worldDir=world
URL=$?
jarName=$?
RAM=$(sed '2q;d' Config.conf)

menu(){
	CONF=$(sed '1q;d' Config.conf)
	if [ $CONF != "CONFIGURE=true" ]; then
		whiptail --title "Config" --msgbox "You need to run the configuration\nNOTE: Does not work on ARM devices like the raspberry pi\nwithout user modification" 8 78
		chmod +x Configure.sh
		sudo ./Configure.sh
	fi
	while [ 1 ]
	do
	CHOICE=$(
	whiptail --backtitle "v0.0.2" --title  "Minecraft Server Menu" --menu "Choose an option" --nocancel 25 65 16 \
		"Start Server" "Makes a minecraft world and starts the server" \
		"Delete World" "Remove minecraft world" \
		"Settings" "Server Settings" \
		"Update" "Update Server" \
		"Exit" "Exits Menu" 3>&2 2>&1 1>&3
	)
	option=$(echo $choice | tr '[:upper:]' '[:lower:]' | sed 's/ //g')
	case $CHOICE in
		"Start Server")
			if [ -d $worldDir ]; then
				clear
                                echo "Please wait..."
				java -Xmx"${RAM: -1}"G -Xms"${RAM: -1}"G -jar minecraft_server* nogui
			fi
			if [ ! -d "$worldDir" ];  then
				whiptail --title "World" --msgbox "A new world will now be made." 8 78
				clear
				java  -Xmx"${RAM: -1}"G -Xms"${RAM: -1}"G -jar minecraft_server* nogui
			fi
		;;
		"Delete World")
			if (whiptail --title "Delete world?" --yesno "Do you really want to delete the world?" 8 78) then
				rm -rf $worldDir
				whiptail --title "Delete World" --msgbox "World now deleted. Start the server to make a new one." 8 78
			fi
		;;
		"Settings")
			./Settings.sh
		;;
		"Update")
				URL=$(whiptail --inputbox "Enter a the latest Minecraft.jar URL. You can find it on the minecraft website" 8 78  --title "Update" 3>&1 1>&2 2>&3)
                                exitstatus=$?
                                if [ $exitstatus = 1 ]; then
                                        exit
                                else
                                        {
                                        echo 30
                                        sleep .2
                                        rm minecraft_server*
                                        echo 60
                                        sleep .2
                                        {
                                                wget $URL
                                        } &> /dev/null
                                        echo 100
                                        jarName="${URL##*/}"
                                        sleep 2
                                        } | whiptail --title "Update" --gauge "Getting update. Please wait..." 6 60 0
                                        whiptail --title "Update" --msgbox "Update installed!\nNOTE:it may have not gotten an update at all if one was not availible" 8 78
                                fi

		;;
		"Exit")
			exit
		;;
	esac
	done
}
menu
