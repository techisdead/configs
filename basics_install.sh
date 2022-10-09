#!/bin/bash
## Run this as sudo - prior to running 
## sudo su

VSCODE_URL=https://go.microsoft.com/fwlink/?LinkID=760868

## aliases

echo "alias ll='ls -alFG'" >> ~/.bashrc


apt install --yes --no-install-recommends \
  wget \
  ca-certificates \
  apt-transport-https \
  gdebi-core \
  gpg  


## subversion
sudo apt install -y  --no-install-recommends subversion


# editors

apt install -y neovim

# sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | \
  tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg
echo "deb https://download.sublimetext.com/ apt/stable/" | \
 tee /etc/apt/sources.list.d/sublime-text.list
 
apt update
apt install -y --no-install-recommends sublime-text
  
# vscode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | \
gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt update
sudo apt install -y code

## pgadmin

wget -qO- https://www.pgadmin.org/static/packages_pgadmin_org.pub | \
 gpg --dearmor -o /etc/apt/trusted.gpg.d/pgadmin.gpg
sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list'
apt update
apt install -y pgadmin4-desktop



