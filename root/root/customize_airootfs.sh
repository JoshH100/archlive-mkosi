#!/bin/bash

set -e -u

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

usermod -s /usr/bin/zsh root
cp -aT /etc/skel/ /root/
chmod 700 /root

sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
systemctl enable sshd
#sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf
pacman-key --init
pacman-key --add /root/jhoffer.gpg
pacman-key --lsign-key B981333915C77E14A7152698DB7329229D306945
pacman-key --lsign-key jhoffer@mines.edu
pacman -U /root/threelayout.pkg.tar --noconfirm
systemctl enable pacman-init.service 
systemctl set-default multi-user.target
#cp /root/mirrorlist /etc/pacman.d/mirrorlist

# Change to CCIT's mirror... 
#echo "Server = https://lug.mines.edu/mirrors/archlinux/$repo/os/$arch" > /etc/pacman.d/mirrorlist
echo "Server = http://labbuild-test1.mines.edu/$repo/os/$arch"  > /etc/pacman.d/mirrorlist
