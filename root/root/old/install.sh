#!/bin/bash
pacman-key --add /root/jhoffer.gpg
pacman-key --lsign-key jhoffer@mines.edu
ansible-playbook -i archlinux-bootstrap/hosts archlinux-bootstrap/build.yml --ask-vault-pass -e "device=/dev/$1"
