# get latest playbook
#rm -rf /root/archlinux-bootstrap*
#wget http://greyfox.mines.edu:3000/archlinux-bootstrap.tar.gz
#tar xzvf /root/archlinux-bootstrap.tar.gz -C /root/

# Get bootstrap playbook

git clone https://github.com/JoshH100/archlinux-bootstrap.git
# patch playbook for NVMe drive (TODOÏ: these can be made default now...)
sed -i 's/}}1/}}p1/g' archlinux-bootstrap/roles/common/tasks/*
sed -i 's/}}2/}}p2/g' archlinux-bootstrap/roles/common/tasks/*
sed -i 's/}}1/}}p1/g' archlinux-bootstrap/roles/uefi/tasks/*
sed -i 's/}}2/}}p2/g' archlinux-bootstrap/roles/uefi/tasks/*

pacman-key --add /root/jhoffer.gpg
pacman-key --lsign-key jhoffer@mines.edu
ansible-playbook -i archlinux-bootstrap/hosts archlinux-bootstrap/build.yml --ask-vault-pass -e "device=/dev/nvme0n1"
