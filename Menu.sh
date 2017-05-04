#!/bin/bash
#!/bin/sh

worldDir=world
URL=$?
jarName=$?

menu(){
	while [ 1 ]
	do
	CHOICE=$(
	whiptail --backtitle "v0.0.1" --title  "Minecraft Server Menu" --menu "Choose an option" 25 65 16 \
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
				java -Xmx1G -Xms1G -jar minecraft_server*
			fi
			if [ ! -d "$worldDir" ];  then
				whiptail --title "World" --msgbox "A new world will now be made." 8 78
				clear
				java  -Xmx1G -Xms1G -jar minecraft_server*
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
			{
				while IFS= read -r line
				do
					echo "$line"
					URL=$line
				done < "ServerSetup.conf"
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
		;;
		"Exit")
			exit
		;;
	esac
	done
}
menu
