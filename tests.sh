#!/bin/bash
set -e
#-------------------------------------------------------------------#
echo "#####..................................................#####"

#------------------------------MIRRORS------------------------------#
echo "#####..........Installing reflector....................#####"
sudo pacman -S --noconfirm --needed reflector
echo "#####..........Finding the fastest servers.............#####"
sudo reflector -l 100 -f 50 --sort rate --threads 5 --verbose --save /tmp/mirrorlist.new && rankmirrors -n 0 /tmp/mirrorlist.new > /tmp/mirrorlist && sudo cp /tmp/mirrorlist /etc/pacman.d
cat /etc/pacman.d/mirrorlist
echo "#####..........Updating mirrorlist.....................#####"
sudo pacman -Syu
#--------------------------XORG VIRTUALBOX--------------------------#
echo "#####..........Installing Xserver......................#####"
sudo pacman --noconfirm --needed -S xorg-server xorg-apps xorg-xinit xorg-twm xterm
echo "#####..........Installing virtualbox. .................#####"
sudo pacman --noconfirm --needed -S virtualbox-guest-utils 
#------------------------------PACKER-------------------------------#
echo "#####..........Installing wget.........................#####"
sudo pacman --needed --noconfirm -S wget
package="packer"
command="packer"
if pacman -Qi $package &> /dev/null; then
echo "#####.........."$package" is already installed.........#####"
else
echo "#####..........Installing "$package"...................#####"
	sudo pacman -S --noconfirm --needed grep sed bash curl pacman jshon expac
	[ -d /tmp/packer ] && rm -rf /tmp/packer
	mkdir /tmp/packer
	wget https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=packer
	mv PKGBUILD\?h\=packer /tmp/packer/PKGBUILD
	cd /tmp/packer
	makepkg -i /tmp/packer --noconfirm
	[ -d /tmp/packer ] && rm -rf /tmp/packer
	if pacman -Qi $package &> /dev/null; then	
echo "#####.........."$package" has been installed...........#####"	
	else
echo "#####.........."$package" has NOT been installed.......#####"
	fi
fi
#--------------------------------I3WM-------------------------------#
echo "#####..........Installing i3lock, i3status.............#####"
sudo pacman -S --noconfirm --needed i3lock i3status
package="j4-dmenu-desktop"
if pacman -Qi $package &> /dev/null; then
echo "#####.........."$package" is already installed.........#####"
else
	if pacman -Qi packer &> /dev/null; then
echo "#####..........Installing "$package" with packer.......#####"
		packer -S --noconfirm --noedit  $package
	elif pacman -Qi pacaur &> /dev/null; then
echo "#####..........Installing "$package" with pacaur.......#####"		
		pacaur -S --noconfirm --noedit  $package
	elif pacman -Qi yaourt &> /dev/null; then
echo "#####..........Installing "$package" with yaourt.......#####"
		yaourt -S --noconfirm $package
	fi
fi
package="i3blocks"
if pacman -Qi $package &> /dev/null; then
echo "#####.........."$package" is already installed.........#####"
else
	if pacman -Qi packer &> /dev/null; then
echo "#####..........Installing "$package" with packer.......#####"
		packer -S --noconfirm --noedit  $package
	elif pacman -Qi pacaur &> /dev/null; then
echo "#####..........Installing "$package" with pacaur.......#####"
		pacaur -S --noconfirm --noedit  $package
	elif pacman -Qi yaourt &> /dev/null; then
echo "#####..........Installing "$package" with yaourt.......#####"
		yaourt -S --noconfirm $package
	fi
	if pacman -Qi $package &> /dev/null; then
echo "#####.........."$package" has been installed...........#####"	
	else
echo "#####.........."$package" has NOT been installed.......#####"
	fi
fi
package="i3-gaps-next-git"
if pacman -Qi $package &> /dev/null; then
echo "#####.........."$package" is already installed.........#####"
else
	if pacman -Qi packer &> /dev/null; then
echo "#####..........Installing "$package" with packer.......#####"
		packer -S --noconfirm --noedit  $package
	elif pacman -Qi pacaur &> /dev/null; then
echo "#####..........Installing "$package" with pacaur.......#####"
		pacaur -S --noconfirm --noedit  $package
	elif pacman -Qi yaourt &> /dev/null; then
echo "#####..........Installing "$package" with yaourt.......#####"
		yaourt -S --noconfirm $package
	fi
	if pacman -Qi $package &> /dev/null; then
echo "#####.........."$package" has been installed...........#####"	
	else
echo "#####.........."$package" has NOT been installed.......#####"
	fi
fi
#------------------------------SOFTWARE-----------------------------#
sudo pacman -S --noconfirm --needed archey3 baobab bleachbit catfish clementine conky curl
sudo pacman -S --noconfirm --needed darktable dconf-editor
sudo pacman -S --noconfirm --needed dmidecode 
sudo pacman -S --noconfirm --needed evince evolution filezilla firefox
sudo pacman -S --noconfirm --needed galculator geary gimp git gksu glances gnome-disk-utility 
sudo pacman -S --noconfirm --needed gnome-font-viewer gnome-screenshot gnome-system-monitor gnome-terminal gnome-tweak-tool 
sudo pacman -S --noconfirm --needed gparted gpick grsync
sudo pacman -S --noconfirm --needed hardinfo hddtemp hexchat htop 
sudo pacman -S --noconfirm --needed inkscape inxi lm_sensors lsb-release meld mlocate mpv
sudo pacman -S --noconfirm --needed nemo net-tools numlockx openshot pinta plank polkit-gnome 
sudo pacman -S --noconfirm --needed redshift ristretto sane screenfetch scrot shotwell 
sudo pacman -S --noconfirm --needed simple-scan simplescreenrecorder smplayer sysstat 
sudo pacman -S --noconfirm --needed terminator thunar transmission-cli transmission-gtk
sudo pacman -S --noconfirm --needed variety vlc vnstat wget unclutter  
sudo systemctl enable vnstat
sudo systemctl start vnstat
sudo pacman -S --noconfirm --needed unace unrar zip unzip sharutils  uudeview  arj cabextract file-roller
#------------------------------PRINTERS-----------------------------#
sudo pacman -S cups cups-pdf ghostscript gsfonts libcups hplip system-config-printer --noconfirm --needed
systemctl enable org.cups.cupsd.service
systemctl start org.cups.cupsd.service
#-------------------------------SOUND-------------------------------#
sudo pacman -S pulseaudio pulseaudio-alsa pavucontrol  --noconfirm --needed
sudo pacman -S alsa-utils alsa-plugins alsa-lib alsa-firmware --noconfirm --needed
sudo pacman -S gst-plugins-good gst-plugins-bad gst-plugins-base gst-plugins-ugly  gstreamer  --noconfirm --needed
#------------------------------NETWORK------------------------------#
sudo pacman -S networkmanager --noconfirm --needed
sudo pacman -S network-manager-applet --noconfirm --needed
sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service
#---------------------------EXTRA SOFTWARE--------------------------#
package="sublime-text-dev"
command="subl3"
if pacman -Qi $package &> /dev/null; then
echo "#####.........."$package" is already installed.........#####"
else
	if pacman -Qi packer &> /dev/null; then
echo "#####..........Installing "$package" with packer.......#####"
		packer -S --noconfirm --noedit  $package
	elif pacman -Qi pacaur &> /dev/null; then
echo "#####..........Installing "$package" with pacaur.......#####"
		pacaur -S --noconfirm --noedit  $package
	elif pacman -Qi yaourt &> /dev/null; then
echo "#####..........Installing "$package" with yaourt.......#####"
		yaourt -S --noconfirm $package
	fi
	if pacman -Qi $package &> /dev/null; then
echo "#####.........."$package" has been installed...........#####"	
	else
echo "#####.........."$package" has NOT been installed.......#####"
	fi
fi
package="neofetch"
command="neofetch"
if pacman -Qi $package &> /dev/null; then
echo "#####.........."$package" is already installed.........#####"
else
	if pacman -Qi packer &> /dev/null; then
echo "#####..........Installing "$package" with packer.......#####"
		packer -S --noconfirm --noedit  $package
	elif pacman -Qi pacaur &> /dev/null; then
echo "#####..........Installing "$package" with pacaur.......#####"
		pacaur -S --noconfirm --noedit  $package
	elif pacman -Qi yaourt &> /dev/null; then
echo "#####..........Installing "$package" with yaourt.......#####"
		yaourt -S --noconfirm $package
	fi
	if pacman -Qi $package &> /dev/null; then
echo "#####.........."$package" has been installed...........#####"	
	else
echo "#####.........."$package" has NOT been installed.......#####"
	fi
fi
#--------------------THEMES, ICONS, CURSORS,CONKY-------------------#
[ -d /tmp/aureola ] && rm -rf "/tmp/aureola" || echo ""
if which git > /dev/null; then
echo "#####..........git has been installed..................#####"
		else
echo "#####..........Installing git..........................#####"
	  	sudo apt-get install git -y
	fi
rm -rf /tmp/aureola
git clone https://github.com/erikdubois/Aureola /tmp/aureola
[ -d ~/.aureola ] && rm -rf ~/.aureola 
mv -f /tmp/aureola ~/.aureola
rm -rf /tmp/aureola
#----------------------DISTRO SPECIFIC SOFTWARE---------------------#
echo "#####..........Installing fonts........................#####"
sudo pacman -S noto-fonts --noconfirm --needed
sudo pacman -S ttf-ubuntu-font-family --noconfirm --needed
sudo pacman -S ttf-droid --noconfirm --noconfirm --needed
sudo pacman -S ttf-inconsolata --noconfirm --needed
echo "#####..........Installing file manager.................#####"
sudo pacman -S nemo --noconfirm --needed
echo "#####..........Installing utilities....................#####"
sudo pacman -S pamac --noconfirm --needed 
sudo pacman -S notify-osd  --noconfirm --needed
sudo pacman -S lxappearance --noconfirm --needed
sudo pacman -S feh --noconfirm --needed
sudo pacman -S arandr --noconfirm --needed
sudo pacman -S qt4 --confirm --needed
sudo pacman -S xorg-xrandr --noconfirm --needed
sudo pacman -S gvfs  --noconfirm --needed
sudo pacman -S compton  --noconfirm --needed
sudo pacman -S volumeicon  --noconfirm --needed
package="playerctl"
description="steering spotify from the keyboard G15 Logitech - volume and next/previous/stop/pause"
if pacman -Qi $package &> /dev/null; then
echo "#####.........."$package" is already installed.........#####"
else
	if pacman -Qi packer &> /dev/null; then
echo "#####..........Installing "$package" with packer.......#####"
		packer -S --noconfirm --noedit  $package
	elif pacman -Qi pacaur &> /dev/null; then
echo "#####..........Installing "$package" with pacaur.......#####"
		pacaur -S --noconfirm --noedit  $package
	elif pacman -Qi yaourt &> /dev/null; then
echo "#####..........Installing "$package" with yaourt.......#####"
		yaourt -S --noconfirm $package
	fi
	if pacman -Qi $package &> /dev/null; then
echo "#####.........."$package" has been installed...........#####"	
	else
echo "#####.........."$package" has NOT been installed.......#####"
	fi
fi
package="pasystray-git"
description="trayicon for sound for bluetooth headphone"
if pacman -Qi $package &> /dev/null; then
echo "#####.........."$package" is already installed.........#####"
else
	if pacman -Qi packer &> /dev/null; then
echo "#####..........Installing "$package" with packer.......#####"
		packer -S --noconfirm --noedit  $package
	elif pacman -Qi pacaur &> /dev/null; then
echo "#####..........Installing "$package" with pacaur.......#####"
		pacaur -S --noconfirm --noedit  $package
	elif pacman -Qi yaourt &> /dev/null; then
echo "#####..........Installing "$package" with yaourt.......#####"
		yaourt -S --noconfirm $package
	fi
	if pacman -Qi $package &> /dev/null; then
echo "#####.........."$package" has been installed...........#####"	
	else
echo "#####.........."$package" has NOT been installed.......#####"
	sudo pacman -U /tmp/packerbuild-1000/pasystray-git/pasystray-git/pasystray-git*  --needed --noconfirm
	fi
fi
#------------------------CREATING ALL FOLDERS-----------------------#
echo "#####..........Creating all folders....................#####"
[ -d $HOME"/.icons" ] || mkdir -p $HOME"/.icons"
[ -d $HOME"/.config/gtk-3.0" ] || mkdir -p $HOME"/.config/gtk-3.0"
[ -d $HOME"/.config/conky" ] || mkdir -p $HOME"/.config/conky"
[ -d $HOME"/.config/variety" ] || mkdir -p $HOME"/.config/variety"
[ -d $HOME"/.config/variety/scripts" ] || mkdir -p $HOME"/.config/variety/scripts"
[ -d $HOME"/.themes" ] || mkdir -p $HOME"/.themes"
[ -d $HOME"/Desktop" ] || mkdir -p $HOME"/Desktop"
[ -d $HOME"/Documents" ] || mkdir -p $HOME"/Documents"
[ -d $HOME"/Downloads" ] || mkdir -p $HOME"/Downloads"
[ -d $HOME"/DATA" ] || mkdir -p $HOME"/DATA"
[ -d $HOME"/Insync" ] || mkdir -p $HOME"/Insync"
[ -d $HOME"/Music" ] || mkdir -p $HOME"/Music"
[ -d $HOME"/Pictures" ] || mkdir -p $HOME"/Pictures"
[ -d $HOME"/Videos" ] || mkdir -p $HOME"/Videos"
[ -d $HOME"/.fonts" ] || mkdir -p $HOME"/.fonts"
[ -d $HOME"/.gimp-2.8" ] || mkdir -p $HOME"/.gimp-2.8"
[ -d $HOME"/.gimp-2.8/scripts" ] || mkdir -p $HOME"/.gimp-2.8/scripts"
[ -d $HOME"/.gimp-2.8/themes" ] || mkdir -p $HOME"/.gimp-2.8/themes"
#-----------------------------AUTOLOGIN-----------------------------#
package="xlogin-git"
if pacman -Qi $package &> /dev/null; then
echo "#####.........."$package" is already installed.........#####"
else
	if pacman -Qi packer &> /dev/null; then
echo "#####..........Installing "$package" with packer.......#####"
		packer -S --noconfirm --noedit  $package
	elif pacman -Qi pacaur &> /dev/null; then
echo "#####..........Installing "$package" with pacaur.......#####"
		pacaur -S --noconfirm --noedit  $package
	elif pacman -Qi yaourt &> /dev/null; then
echo "#####..........Installing "$package" with yaourt.......#####"
		yaourt -S --noconfirm $package
	fi
	if pacman -Qi $package &> /dev/null; then
echo "#####.........."$package" has been installed...........#####"	
	else
echo "#####.........."$package" has NOT been installed.......#####"
	fi
fi
echo "#####..........Setting system to autologin the user....#####"
read -p "Type your login name: " name
sudo systemctl enable xlogin@$name
git clone https://github.com/erikdubois/archi3 ~/.config/i3
sudo --noconfirm --needed reboot
