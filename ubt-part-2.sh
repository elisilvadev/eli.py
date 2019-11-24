#!/bin/bash
echo "Seu nome de usuário é:"
whoami
echo "Info de hora atual e tempo que o computador está ligado:"
uptime
echo "O script está executando do diretório:"
pwd
sudo add-apt-repository -yn ppa:dyatlov-igor/materia-theme
sudo add-apt-repository -yn ppa:papirus/papirus
sudo add-apt-repository -yn ppa:papirus/papirus-dev
sudo add-apt-repository -y ppa:papirus/hardcode-tray
sudo apt install -y breeze-cursor-theme folder-color fonts-emojione fonts-powerline gnome-tweaks hardcode-tray materia-gtk-theme materia-kde papirus-icon-theme qt4-qtconfig qt5ct
wget -c http://ftp.us.debian.org/debian/pool/main/f/fonts-quicksand/fonts-quicksand_0.2016-2_all.deb #update_link
sudo apt install -y ./fonts-quicksand*.deb
sudo sed -i 's/Roboto/Quicksand/g' /usr/share/themes/Materia*/gnome-shell/gnome-shell.css
echo DPkg::Post-Invoke \{\"sed -i \'s/Roboto/Quicksand/g\' /usr/share/themes/Materia*/gnome-shell/gnome-shell.css\"\;\}\; | sudo tee /etc/apt/apt.conf.d/100materia-quicksand
sudo sed -i 's/Icon=\/usr\/share\/pixmaps\/guvcview\/guvcview.png/Icon=guvcview/g' /usr/share/applications/guvcview.desktop
echo DPkg::Post-Invoke \{\"sed -i \'s/Icon=\\/usr\\/share\\/pixmaps\\/guvcview\\/guvcview.png/Icon=guvcview/g\' /usr/share/applications/guvcview.desktop\"\;\}\; | sudo tee /etc/apt/apt.conf.d/100guvcview
sudo sed -i 's/Icon=\/opt\/resolve\/graphics\/DV_Resolve.png/Icon=resolve/g' /usr/share/applications/com.blackmagicdesign.resolve.desktop
sudo sed -i 's/ubuntu-dock@ubuntu.com//g' /usr/share/gnome-shell/modes/ubuntu.json
#sudo sed -i 's/ubuntu-appindicators@ubuntu.com//g' /usr/share/gnome-shell/modes/ubuntu.json
gsettings set org.gnome.desktop.interface font-name 'Quicksand Regular 11'
gsettings set org.gnome.desktop.interface gtk-theme Materia-dark-compact
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
gsettings set org.gnome.desktop.interface cursor-theme Breeze_Snow
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Quicksand Bold 11'
gsettings set org.gnome.shell.extensions.user-theme name Materia-dark-compact
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.screensaver picture-options wallpaper
gsettings set org.gnome.desktop.screensaver picture-uri 'file:////usr/share/gnome-control-center/pixmaps/noise-texture-light.png'
gsettings set org.gnome.desktop.screensaver primary-color '#000000'
gsettings set org.gnome.desktop.screensaver secondary-color '#000000'
gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
gsettings set org.gnome.gedit.preferences.editor scheme oblivion
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.nautilus.desktop trash-icon-visible false
gsettings set org.gnome.nautilus.desktop volumes-visible false
gsettings set org.gnome.nautilus.icon-view default-zoom-level standard
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic true
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 'uint32 5000'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 3600
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type  nothing
gsettings set org.gnome.shell enabled-extensions "['dash-to-panel@jderose9.github.com', 'gsconnect@andyholmes.github.io', 'ubuntu-appindicators@ubuntu.com', 'user-theme@gnome-shell-extensions.gcampax.github.com', 'blyr@yozoon.dev.gmail.com', 'focus-my-window@varianto25.com', 'youtube-search-provider@atareao.es', 'alternate-tab@gnome-shell-extensions.gcampax.github.com', 'status-area-horizontal-spacing@mathematical.coffee.gmail.com', 'remove-dropdown-arrows@mpdeimos.com', 'openweather-extension@jenslody.de']"
gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'firefox.desktop', 'org.gnome.FeedReader.desktop', 'rambox.desktop', 'org.kde.kpat.desktop', 'steam.desktop', 'net.lutris.Lutris.desktop', 'ToneLib-Zoom.desktop', 'carla.desktop', 'cockos-reaper.desktop', 'com.blackmagicdesign.resolve.desktop', 'gimp.desktop']"
gsettings set org.gtk.Settings.FileChooser sort-directories-first true
wget -c https://raw.githubusercontent.com/rauldipeas/ubuntu-postinst/master/resources/dash-to-panel.cfg
dconf load /org/gnome/shell/extensions/dash-to-panel/ < dash-to-panel.cfg

#GDM
sudo sed -i 's/Ubuntu/Quicksand/g' /usr/share/gnome-shell/theme/ubuntu.css
echo DPkg::Post-Invoke \{\"sed -i \'s/Ubuntu/Quicksand/g\' /usr/share/gnome-shell/theme/ubuntu.css\"\;\}\; | sudo tee -a /etc/apt/apt.conf.d/100gdm-dark
xhost +SI:localuser:gdm
sudo su gdm -s /bin/bash #executar comandos abaixo como usuário GDM
$# gsettings set org.gnome.desktop.interface gtk-theme Materia-dark-compact
$# gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
$# gsettings set org.gnome.desktop.interface cursor-theme Breeze_Snow
$# gsettings set org.gnome.login-screen logo '/usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.png'
$# gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
#$# gsettings set org.gnome.shell enabled-extensions "['user-theme@gnome-shell-extensions.gcampax.github.com']"
#$# gsettings set org.gnome.shell.extensions.user-theme name Materia-dark-compact
$# exit
xhost -SI:localuser:gdm

#Terminal
sudo apt install -y curl fish undistract-me
wget -c https://github.com/hbin/top-programming-fonts/raw/master/Monaco-Linux.ttf
mkdir -p ~/.fonts;cp -rv Monaco* ~/.fonts
gsettings set org.gnome.desktop.interface monospace-font-name 'Monaco Regular 11'
wget -c https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/DroidSansMono.zip
unzip DroidSansMono.zip -d ~/.fonts
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
bash ~/.bash_it/install.sh --silent
sed -i 's/bobby/powerline/g' ~/.bashrc
echo '
# Undistract-Me
. /usr/share/undistract-me/long-running.bash
notify_when_long_running_commands_finish_install' >> ~/.bashrc
sudo sed -i 's/took/levou/g' /usr/share/undistract-me/long-running.bash
sudo sed -i 's/dialog-information/xterm/g' /usr/share/undistract-me/long-running.bash
sudo sed -i 's/Long\ command\ completed/Comando\ concluído\!/g' /usr/share/undistract-me/long-running.bash
echo DPkg::Post-Invoke \{\"sed -i \'s/took/levou/g\' /usr/share/undistract-me/long-running.bash\"\;\}\; | sudo tee /etc/apt/apt.conf.d/100undistract-me
echo DPkg::Post-Invoke \{\"sed -i \'s/dialog-information/xterm/g\' /usr/share/undistract-me/long-running.bash\"\;\}\; | sudo tee -a /etc/apt/apt.conf.d/100undistract-me
echo DPkg::Post-Invoke \{\"sed -i \'s/Long\ command\ completed/Comando\ concluído\!/g\' /usr/share/undistract-me/long-running.bash\"\;\}\; | sudo tee -a /etc/apt/apt.conf.d/100undistract-me
sudo su #executar comandos abaixo como usuário root
$# chsh -s `which fish`
$# curl -L https://get.oh-my.fish | fish
$# omf install bobthefish
$# exit

#appimage daemon
wget -c https://github.com/AppImage/appimaged/releases/download/continuous/appimaged_1-alpha-git05c4438.travis209_amd64.deb #update_link
sudo apt install -y ./appimaged*.deb
sudo cp -v /usr/share/applications/appimaged.desktop /etc/xdg/autostart/

#AsarUI
wget -c https://github.com/myazarc/AsarUI/releases/download/v1.0.2/asarui_1.0.2_amd64.deb
sudo apt install -y ./asarui*.deb
#Cool Retro Term
sudo add-apt-repository -y ppa:vantuz/cool-retro-term
sudo apt install -y cool-retro-term
#Crow Translate
wget -c https://github.com/crow-translate/crow-translate/releases/download/2.2.0/crow-translate-2.2.0-amd64.deb #update_link
sudo apt install -y ./crow-translate*.deb
#Etcher
wget -c https://github.com/balena-io/etcher/releases/download/v1.5.57/balena-etcher-electron_1.5.57_amd64.deb #update_link
sudo apt install -y ./balena-etcher*.deb
#Githun Desktop
wget -c https://github.com/shiftkey/desktop/releases/download/release-2.1.0-linux1/GitHubDesktop-linux-2.1.0-linux1.deb #update_link
sudo apt install -y ./GitHubDesktop-linux*.deb
#GoTop and chorme
wget -c https://github.com/cjbassi/gotop/releases/download/3.0.0/gotop_3.0.0_linux_amd64.deb
sudo apt install -y ./gotop*.deb
echo "
# GoTop
alias gotop-monokai='gotop -c monokai'" >> ~/.bashrc

wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome*.deb
#mega
wget -c https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/nautilus-megasync-xUbuntu_18.04_amd64.deb
wget -c https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/megasync-xUbuntu_18.04_amd64.deb
sudo apt install -y ./nautilus-megasync*.deb ./megasync*.deb

#OCS URL
wget -c https://github.com/rauldipeas/ubuntu-postinst/raw/master/resources/ocs-url_3.1.0-0ubuntu1_amd64.deb
sudo apt install -y ./ocs-url*.deb
#SPEED TEST
sudo wget -O /usr/local/bin/speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py
sudo chmod +x -v /usr/local/bin/speedtest-cli
#STACE
wget -c https://github.com/oguzhaninan/Stacer/releases/download/v1.1.0/stacer_1.1.0_amd64.deb
sudo apt install -y ./stacer*.deb
#STREMIO
wget -c https://dl.strem.io/linux/v4.4.54/stremio_4.4.52-1_amd64.deb
sudo apt install -y ./stremio*.deb
#VIRTUAL BOX
wget -c https://download.virtualbox.org/virtualbox/6.0.12/virtualbox-6.0_6.0.12-133076~Ubuntu~bionic_amd64.deb
sudo apt install -y --no-install-recommends ./virtualbox*.deb
#TEAMVIEWER
#wget -c https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
#sudo apt install -y teamviewer*.deb
#WEB PIN
#wget -c https://launchpadlibrarian.net/440481065/libgranite-common_5.2.5+r1436+pkg110~ubuntu5.0.1_all.deb
#wget -c https://launchpadlibrarian.net/440481067/libgranite5_5.2.5+r1436+pkg110~ubuntu5.0.1_amd64.deb
wget -c https://github.com/rauldipeas/ubuntu-postinst/raw/master/resources/com.github.artemanufrij.webpin_0.2.1_amd64.deb
sudo apt install -y ./libgranite* ./com.github.artemanufrij.webpin*.deb

#APT APPS
sudo add-apt-repository -yn ppa:mc3man/bionic-media # Media codecs
sudo add-apt-repository -yn ppa:xuzhen666/gnome-mpv # Celluloid
sudo add-apt-repository -y ppa:mkusb/ppa # MKUSB
#sudo add-apt-repository -y ppa:atareao/telegram
sudo apt install -y --no-install-recommends gnome-mpv kpat mkusb sweeper
gsettings set io.github.celluloid-player.Celluloid mpv-options --save-position-on-quit
echo 'StartupWMClass=kpat' | sudo tee -a /usr/share/applications/org.kde.kpat.desktop
sudo apt install -y audacity caffeine deja-dup deluge-gtk deluge-web deluged galculator galternatives gnome-alsamixer gnome-sushi gnome-usage hardinfo nautilus-dropbox neofetch openssh-server p7zip-full synaptic tilix unrar vinagre x11vnc #telegram
sudo apt autoremove --purge -y gnome-terminal
sudo rm -rfv /usr/share/applications/caffeine.desktop /usr/share/applications/debian-*xterm.desktop /usr/share/applications/guidus.desktop
sudo sed -i 's/Icon=\/usr\/share\/pixmaps\/gnome-alsamixer\/gnome-alsamixer-icon.png/Icon=gnome-alsamixer-icon/g' /usr/share/applications/gnome-alsamixer.desktop
sudo sed -i 's/Icon=\/usr\/share\/hardinfo\/pixmaps\/logo.png/Icon=hardinfo/g' /usr/share/applications/hardinfo.desktop
echo DPkg::Post-Invoke \{\"sed -i \'s/Icon=\\/usr\\/share\\/hardinfo\\/pixmaps\\/logo.png/Icon=hardinfo/g\' /usr/share/applications/hardinfo.desktop\"\;\}\; | sudo tee /etc/apt/apt.conf.d/100hardinfo
sudo update-alternatives --set x-cursor-theme /etc/X11/cursors/Breeze_Snow.theme
sudo update-alternatives --set x-terminal-emulator /usr/bin/tilix.wrapper
sudo wget -cO /usr/local/bin/neofetch https://raw.githubusercontent.com/dylanaraps/neofetch/master/neofetch
sudo chmod +x -v /usr/local/bin/neofetch
#GESTURES
sudo gpasswd -a $USER input
sudo apt install -y libinput-tools python3-setuptools wmctrl xdotool
git clone https://github.com/bulletmark/libinput-gestures.git
cd libinput-gestures;sudo make install;cd ..
git clone https://gitlab.com/cunidev/gestures
cd gestures;sudo python3 setup.py install;cd ..
sudo sed -i 's/org.cunidev.gestures/libinput-gestures/g' /usr/share/applications/org.cunidev.gestures.desktop
sudo mv -v /usr/share/applications/libinput-gestures.desktop /etc/xdg/autostart/
#FLATPAK
sudo apt install -y gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.gtk.Gtk3theme.Materia-dark-compact
#FeedREADER
flatpak install flathub org.gnome.FeedReader
#REMOVER SNAPS APPS
sudo snap remove gnome-3-28-1804 gnome-calculator gnome-characters gnome-logs gnome-system-monitor gtk-common-themes
sudo snap remove core18
#Hardcode-tray apply
sudo hardcode-tray --apply
#AutoStart NoDisplay=false
sudo sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/*.desktop
mkdir -p ~/.config/autostart
cp /etc/xdg/autostart/at-spi-dbus-bus.desktop ~/.config/autostart #acessibilidade
cp /etc/xdg/autostart/caffeine.desktop ~/.config/autostart #tela_sempre_ativa
cp /etc/xdg/autostart/gnome-software-service.desktop ~/.config/autostart #central_de_programas
cp /etc/xdg/autostart/gnome-welcome-tour.desktop ~/.config/autostart #tela_de_boas_vindas
cp /etc/xdg/autostart/orca-autostart.desktop ~/.config/autostart #leitor_de_tela
cp /etc/xdg/autostart/org.gnome.SettingsDaemon.A11ySettings.desktop ~/.config/autostart #acessibilidade
cp /etc/xdg/autostart/org.gnome.SettingsDaemon.Clipboard.desktop ~/.config/autostart #área_de_transferência
cp /etc/xdg/autostart/org.gnome.SettingsDaemon.PrintNotifications.desktop ~/.config/autostart #impressoras
cp /etc/xdg/autostart/org.gnome.SettingsDaemon.Sharing.desktop ~/.config/autostart #compartilhamento
cp /etc/xdg/autostart/org.gnome.SettingsDaemon.Smartcard.desktop ~/.config/autostart #cartões_inteligentes
cp /etc/xdg/autostart/org.gnome.SettingsDaemon.Wacom.desktop ~/.config/autostart #superfície_de_controle
cp /etc/xdg/autostart/snap-userd-autostart.desktop ~/.config/autostart #snap
cp /etc/xdg/autostart/spice-vdagent.desktop ~/.config/autostart #acesso_remoto
cp /etc/xdg/autostart/update-notifier.desktop ~/.config/autostart #atualizador_de_programas
echo X-GNOME-Autostart-enabled=false | tee -a ~/.config/autostart/*.desktop
