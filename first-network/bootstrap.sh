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
