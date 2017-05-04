#!/bin/bash
#!/bin/sh

wordDir=$PWD/world

makeWorld(){
	if ( ! -d $wordDir )
		whiptail --title "Minecraft World" --msgbox "A new minecraft world will be made" 8 78
	else
		whiptail --title "Minecraft World" --msgbox "A minecraft world aready exist. Please delete the existing one" 8 78
	fi
}

makeWorld
