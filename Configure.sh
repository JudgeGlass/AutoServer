#!/bin/bash
#!/bin/sh

CONF=ServerSetup.conf

configure(){
	apt update -y
	apt upgrade -y
	{
		echo "Insalling Java..."
		{
			apt install openjdk-8-jre -y
		} &> /dev/null
		echo 50
		echo "Getting Minecraft Jar Files..."
		{
			while IFS= read -r line
			do
					echo "$line"
					URL=$line
			done < "$CONF"
                        wget $URL
                } &> /dev/null
		echo 70
		echo "Test Launching Jar"
		{
			java -jar minecraft_server* nogui
		} &> /dev/null
		echo 90
		echo "Changing File Permissions..."
		{
			chmod +x *.sh
			chmod -R 777 $PWD
			chmod -R 777 $PWD/*
		} &> /dev/null
		sleep 0.6
		echo 100
		sleep 1
	} | whiptail --title " Configuring " --gauge "Please wait. This may take awhile..." 6 60 0 
	if (whiptail --title "Minecraft EULA" --yesno "Do you accept the Minecraft EULA?\nVisit https://account.mojang.com/documents/minecraft_eula" 8 78) then
		sed -i -e "s/\(eula=\).*/\1true/" eula.txt
		sed -i -e "s/\(CONFIGURE=\).*/\1true/" Config.conf
		./Menu.sh
	else
		whiptail --title "Minecraft EULA" --msgbox "You can not continue unless you accept the eula" 8 78
		exit
	fi
}

if [ "$EUID" != 0 ]; then
	whiptail --title "ERROR" --msgbox "Please run as root!" 8 78
	exit
fi
configure
