#!/bin/bash
#!/bin/sh
#!/bin/ksh

jar_File=$PWD/minecraft_server.1.11.2.jar

download(){
	if (whiptail --title "Install" --yesno "Would you like to install?" 8 78) then
		whiptail --title "Downloading" --msgbox "Now getting the required files..." 8 78
		{
		for ((i = 0; i<= 1; i+=100)); do
			{
				if [ ! -e $jar_File ] ; then
					wget https://s3.amazonaws.com/Minecraft.Download/versions/1.11.2/minecraft_server.1.11.2.jar
				fi
			} &> /dev/null
			echo $i
			sleep 1.0
		done
		} | whiptail --gauge "Getting files ..." 6 50 0
		whiptail --title "Done" --msgbox "Done getting files!" 8 78
	else
		exit
	fi
}

download
