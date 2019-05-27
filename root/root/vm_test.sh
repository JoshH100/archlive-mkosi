#!/bin/bash
pacman-key --add /root/jhoffer.gpg
pacman-key --lsign-key jhoffer@mines.edu
ansible-playbook -i archinstall/hosts archinstall/site.yml --ask-vault-pass --extra-vars "device=/dev/$1"
