#!/usr/bin/bash
sudo su
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
sleep 3s
yum install -y nfs-utils rpcbind
chkconfig nfs on
chkconfig rpcbind on
service rpcbind start
service nfs start
mkdir -p /share

echo "/share 192.168.33.11(rw,no_root_squash,no_subtree_check)" >> /etc/exports
echo "/share 192.168.33.12(rw,no_root_squash,no_subtree_check)" >> /etc/exports
echo "/share 192.168.33.13(rw,no_root_squash,no_subtree_check)" >> /etc/exports
echo "/share 192.168.33.21(rw,no_root_squash,no_subtree_check)" >> /etc/exports
echo "/share 192.168.33.22(rw,no_root_squash,no_subtree_check)" >> /etc/exports
echo "/share 192.168.33.23(rw,no_root_squash,no_subtree_check)" >> /etc/exports
echo "/share 192.168.33.24(rw,no_root_squash,no_subtree_check)" >> /etc/exports
exportfs -a
