#!/bin/bash
#!/bin/sh

configure(){
	{
		{
			apt install openjdk-8-jre -y
		} &> /dev/null
		echo 50
		{
                        wget https://s3.amazonaws.com/Minecraft.Download/versions/1.11.2/minecraft_server.1.11.2.jar
                } &> /dev/null
		echo 70
		{
			java -jar minecraft_server.1.11.2.jar
		} &> /dev/null
		echo 90
		{
			chmod +x *.sh
		} &> /dev/null
		echo 100
		sleep 1
	} | whiptail --title "Configuring" --gauge "Please wait. This may take awhile..." 6 60 0 
	if (whiptail --title "Minecraft EULA" --yesno "Do you accept the Minecraft EULA?" 8 78) then
		sed -i -e "s/\(eula=\).*/\1true/" eula.txt
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
