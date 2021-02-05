#!/bin/bash


sudo cp /home/vmteam/LinuxVMs_04022021.txt /home/xx
sudo chown xx: /home/vmteam/LinuxVMs_04022021.txt
sudo dos2unix /home/xx/LinuxVMs_04022021.txt
awk '{print $2}' /home/xx/LinuxVMs_04022021.txt >> ansible_host_file
awk '{print $3}' /home/xx/LinuxVMs_04022021.txt >> ansible_host_file
sed -i 's/PublicIp//g'    /home/xx/ansible_host_file
sed -i 's/-//g' /home/xx/ansible_host_file
sed -i '/^\s*$/d' /home/xx/ansible_host_file
sed -i 's/IpAddress1/ /g' /home/xx/ansible_host_file
sed -i '/^\s*$/d' /home/xx/ansible_host_file



awk '
  NR==FNR {a[$1];next}

  $1=="[all_linux_hosts]",0 {
    if ( $1 in a ) delete a[$1]
  };1

  END {
    for (host in a) print host
  }
' /home/xx/ansible_host_file /home/xx/hosts >> /home/xx/hosts
