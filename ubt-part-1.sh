#!/bin/bash
echo "Seu nome de usuário é:"
whoami
echo "Info de hora atual e tempo que o computador está ligado:"
uptime
echo "O script está executando do diretório:"
pwd

echo "#Atualização e limpeza"
echo "Aguarde!
sudo apt update;sudo apt dist-upgrade -y
sudo apt install -y deborphan
deborphan | xargs sudo apt autoremove --purge -y

echo "#Liquorix"
echo "Aguarde!
#sudo add-apt-repository -y ppa:damentz/liquorix
wget -c http://mirrors.kernel.org/ubuntu/pool/main/l/linux-firmware/linux-firmware_1.182_all.deb
sudo apt install -y ./linux-firmware*.deb
sudo apt install -y linux-headers-liquorix-amd64 linux-image-liquorix-amd64
sudo apt autoremove --purge -y linux*generic*
sudo apt install -y intel-microcode iucode-tool thermald

echo "#Otimizações de desempenho"
echo "Aguarde!
echo 'hard stack unlimited
nproc unlimited
nofile 1048576
as unlimited
cpu unlimited
fsize unlimited
msgqueue unlimited
locks unlimited
* hard nofile 1048576
@audio   -  nice      -19' | sudo tee /etc/security/limits.d/rauldipeas.conf
echo 'vm.swappiness=10
net.ipv4.tcp_syncookies=1
net.ipv4.ip_forward=1
net.ipv4.tcp_dsack=0
#net.ipv4.tcp_sack=0
fs.file-max=100000
kernel.sched_migration_cost_ns=5000000
kernel.sched_autogroup_enabled=0
vm.dirty_background_bytes=16777216
vm.dirty_bytes=50331648
kernel.pid_max=4194304' | sudo tee /etc/sysctl.d/rauldipeas.conf
#sudo sed -i 's/; realtime/realtime/g' /etc/pulse/daemon.conf
systemctl --user mask evolution-addressbook-factory.service evolution-calendar-factory.service evolution-source-registry.service
echo "Otimizações de desempenho prontas" 

echo "Plymouth executando..."
sudo sed -i 's/Window.SetBackgroundTopColor (0.16, 0.00, 0.12);     # Nice colour on top of the screen fading to/Window.SetBackgroundTopColor (0.00, 0.00, 0.00);     # Nice colour on top of the screen fading to/g' /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script
sudo sed -i 's/Window.SetBackgroundBottomColor (0.16, 0.00, 0.12);  # an equally nice colour on the bottom/Window.SetBackgroundBottomColor (0.00, 0.00, 0.00);  # an equally nice colour on the bottom/g' /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script
wget -c https://github.com/rauldipeas/ubuntu-postinst/raw/master/resources/ubuntu-logo.png
sudo cp -v ubuntu-logo.png /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.png

echo "Plymouth executado com sucesso..."

echo "Preparando config do grub.."
sudo sed -i 's/quiet splash/quiet splash loglevel=0 logo.nologo vt.global_cursor_default=0 mitigations=off/g' /etc/default/grub
sudo sed -i 's/44,0,30,0/00,0,00,0/g' /usr/share/plymouth/themes/default.grub
echo DPkg::Post-Invoke \{\"sed -i \'s/44,0,30,0/00,0,00,0/g\' /usr/share/plymouth/themes/default.grub\"\;\}\; | sudo tee /etc/apt/apt.conf.d/100grub-dark
echo 'options nvidia-drm modeset=1' |sudo tee /lib/modprobe.d/nvidia-drm.conf
echo 'RESUME=none' | sudo tee /etc/initramfs-tools/conf.d/resume
echo 'FRAMEBUFFER=y' | sudo tee /etc/initramfs-tools/conf.d/splash
sudo update-initramfs -u -k all
sudo update-grub
echo "grub foi atualazido."
echo "-------------------"
echo "configurando GDM"
sudo sed -i 's/2c001e/000000/g' /usr/share/gnome-shell/theme/ubuntu.css
echo DPkg::Post-Invoke \{\"sed -i \'s/2c001e/000000/g\' /usr/share/gnome-shell/theme/ubuntu.css\"\;\}\; | sudo tee /etc/apt/apt.conf.d/100gdm-dark

echo "Configuracoes do GDM prontas"
echo "-------------------"
echo "GNOME Shell Extensions #tray-fix"
sudo apt install -y build-essential chrome-gnome-shell gir1.2-gtkclutter-1.0 git gnome-shell-extension-remoe-dropdown-arrows gnome-shell-extension-weather gnome-shell-extensions
# Blyr
git clone https://github.com/yozoon/gnome-shell-extension-blyr
cd gnome-shell-extension-blyr/;make local-install;cd ..
# Dash to panel
git clone https://github.com/home-sweet-gnome/dash-to-panel.git
cd dash-to-panel;make install;cd ..
# Tray icons
#git clone https://github.com/zhangkaizhao/gnome-shell-extension-tray-icons ~/.local/share/gnome-shell/extensions/tray-icons@zhangkaizhao.com
# GSConnect
wget -c https://github.com/andyholmes/gnome-shell-extension-gsconnect/releases/download/v24/gsconnect@andyholmes.github.io.zip #update_link
mkdir -pv ~/.local/share/gnome-shell/extensions
rm -rfv ~/.local/share/gnome-shell/extensions/gsconnect@andyholmes.github.io
unzip -o gsconnect@andyholmes.github.io.zip -d ~/.local/share/gnome-shell/extensions/gsconnect@andyholmes.github.io
# Coverflow
#git clone https://github.com/dmo60/CoverflowAltTab
#mv -v CoverflowAltTab/CoverflowAltTab@dmo60.de/ ~/.local/share/gnome-shell/extensions/
# Focus my window
git clone https://github.com/v-dimitrov/gnome-shell-extension-stealmyfocus ~/.local/share/gnome-shell/extensions/focus-my-window@varianto25.com/
# YouTube search provider
git clone https://gitlab.gnome.org/atareao/youtube-search-provider.git ~/.local/share/gnome-shell/extensions/youtube-search-provider@atareao.es
# Status area horizontal spacing
git clone https://gitlab.com/p91paul/status-area-horizontal-spacing-gnome-shell-extension
mv -v status-area-horizontal-spacing-gnome-shell-extension/status-area-horizontal-spacing@mathematical.coffee.gmail.com/ ~/.local/share/gnome-shell/extensions/
# GrownUp Notifications
git clone https://github.com/jimmytheneutrino/grownup_notifications ~/.local/share/gnome-shell/extensions/grownup_notifications@11.2017.jimmytheneutrino/

echo "Feito aguarde!"
echo "--------------"
echo "Ubuntu Studio Apps"
echo "instalando Aguarde..."

sudo usermod -aG audio $USER
sudo usermod -aG video $USER
echo jackd2 jackd/tweak_rt_limits string true | sudo debconf-set-selections
sudo add-apt-repository -y ppa:ubuntustudio-ppa/backports
sudo apt install -y --no-install-recommends laditools ubuntustudio-controls patchage
sudo apt install -y carla
sudo sed -i 's/256/224/g' /usr/share/ubuntustudio-controls/ubuntustudio-controls.glade
echo DPkg::Post-Invoke \{\"sed -i \'s/256/224/g\' /usr/share/ubuntustudio-controls/ubuntustudio-controls.glade\"\;\}\; | sudo tee /etc/apt/apt.conf.d/100ubuntustudio-controls
sudo rm -rfv /usr/share/applications/ladi-control-center.desktop /usr/share/applications/ladi-player.desktop /usr/share/applications/ladi-system-log.desktop
echo '#!/bin/bash
ubuntustudio-controls' | sudo tee /usr/local/bin/ladi-control-center
sudo chmod +x /usr/local/bin/ladi-control-center
mkdir -p ~/.config/autostart
cp -rfv /usr/share/applications/ladi-system-tray.desktop ~/.config/autostart/
echo DPkg::Post-Invoke \{\"find /usr/share/icons/Papirus* -type f -name ladi* -exec sed -i \'s/4285f4/4e9a06/g\' {} \\\;\"\;\}\; | sudo tee /etc/apt/apt.conf.d/100laditray-papirus
#echo '#!/bin/sh -e
#find /usr/share/icons/Papirus* -type f -name ladi* -exec sed -i 's/4285f4/4e9a06/g' {} \;' | sudo tee /etc/rc.local
#sudo chmod +x -v /etc/rc.local
echo "Tudo pronto"
echo "-----------------"
echo  "fim!"
echo "instalando editor de imagem"
sudo add-apt-repository -y ppa:otto-kesselgulasch/gimp
sudo apt install -y gimp inkscape rawtherapee
sudo apt install -y --no-install-recommends kcolorchooser
echo 'StartupWMClass=kcolorchooser' | sudo tee -a /usr/share/applications/org.kde.kcolorchooser.desktop 
echo "aguarde..."

wget -c https://github.com/rauldipeas/ubuntu-postinst/raw/master/resources/ffmulticonverter_1.8.0-dmo1-1ubuntu1-rauldipeas_all.deb
sudo apt install -y ./ffmulticonverter*rauldipeas*.deb ocl-icd-libopencl1
wget -c https:// #LINK_DO_DAVINCI_RESOLVE
unzip DaVinci_Resolve*.zip;./DaVinci_Resolve*Linux.run
echo 'StartupWMClass=resolve' | sudo tee -a /usr/share/applications/com.blackmagicdesign.resolve.desktop
echo 'Categories=AudioVideo;' | sudo tee -a /usr/share/applications/com.blackmagicdesign.resolve.desktop
sudo rm -rfv /usr/share/applications/com.blackmagicdesign.resolve-*.desktop

wget -c https://github.com/ramboxapp/community-edition/releases/download/0.6.9/Rambox-0.6.9-linux-amd64.deb #update_link
sudo apt install -y ./Rambox*.deb

sudo add-apt-repository -y ppa:lutris-team/lutris
sudo apt install -y libvulkan1:i386 lutris xboxdrv
wget -c http://repo.steampowered.com/steam/archive/precise/steam_latest.deb
sudo apt -y install ./steam_latest.deb

sudo apt install -y diodon

echo "Pronto"


