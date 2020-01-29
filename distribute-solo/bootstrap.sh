#!/usr/bin/bash
sudo su
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
sleep 3s
yum install -y epel-release
yum install -y vim
yum install -y golang

yum remove docker docker-common docker-selinux docker-engine
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum makecache fast
yum -y install docker-ce
yum -y install docker-compose
service docker start

mkdir -p /etc/docker
echo {\"registry-mirrors\": [\"https://8w1wqmsz.mirror.aliyuncs.com\"]} > /etc/docker/daemon.json
service docker restart



mkdir -p /opt/gopath
echo "export GOPATH=/opt/gopath" >> /etc/profile
echo "export GOPROXY=https://goproxy.io,direct" >> /etc/profile
source /etc/profile
mkdir -p /opt/gopath/src/github.com/hyeprledger/fabric

yum -y install net-tools

yum install -y nfs-utils rpcbind
chkconfig nfs on
chkconfig rpcbind on
service rpcbind start
service nfs start
mkdir /opt/share
mount -t nfs 192.168.33.25:/share /opt/share
echo "192.168.33.25:/share /opt/share nfs rw,tcp,intr 0 1" >> /etc/fstab

cp -r /opt/share/ /opt/gopath/src/github.com/hyeprledger/fabric
