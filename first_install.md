# First install

Ubuntu 20.04

## Basics

* `sudo apt-get install build-essential` for build tools
* Open file manager and 
   - add permissions to columns in 'list columns' (under preferences)
   - check 'show hidden files'
   - change to list view
* Edit .bashrc
   - alias ll='ls -alFG'
   - add shortcut aliases for ssh etc (stored offline)
* install tweaks for gnome `apt install gnome-tweak-tool`

## Basic utilities

* Basic text editor - sublime https://www.sublimetext.com/docs/3/linux_repositories.html
* nvim - `sudo apt install neovim`
* git `sudo apt install git`
  - Because I use 2fa I need secure storage for PAT   
  - use `libsecret` following https://www.softwaredeveloper.blog/git-credential-storage-libsecret
  
```
sudo apt-get install libsecret-1-0 libsecret-1-dev
cd /usr/share/doc/git/contrib/credential/libsecret
sudo make
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
```
  - 
* svn `sudo apt install subversion`
    - check and update ssh settings in .subversion/
    - basic version in dotfiles repo
* Redshift `sudo apt-get install redshift redshift-gtk`
    - save config file (see GH)
    - run `redshift-gtk` to enable toolbar widget and set to autostart
* tmux
  
## move `/home` and `/srv` to new  disks

* use `blkid` to identify disks (sdc1 - will be /srv and sdb1 - will be home)
* rm `/srv` and edit `/etc/fstab` to add mount point for dev/sdc1
* add temp mount point for /dev/sdb1 on /mnt
* copy /home/* to /mnt
* mv /home -> /home.bak
* mkdir /home
* unmount /dev/sdb1
* edit /etc/fstab/ to point /dev/sdb1 to /home
* `sudo mount -a`
* reboot and check it all holds
* rm /home.bak

# tensorflow - in cuda/python etc

I'm going to use miniconda - conda is designed for different software (so can manage cuda/python/R in the same environment.  `reticulate` plays nicely with it, and miniconda avoids downlowding the bloatware of anaconda.

## python/conda setup

```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh

# I don't want to activate the base environment everytime I open a shell
conda config --set auto_activate_base false
```

Install tensorflow (could it really be this easy)

```
conda create --name tf_gpu 
activate tf_gpu
conda install tensorflow-gpu 
```

# R and Rstudio

```
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo apt update

sudo apt install r-base r-base-core r-recommended r-base-dev

# to help with spatial packages
sudo apt install libgdal-dev libproj-dev libgeos-dev libudunits2-dev libnode-dev libcairo2-dev libnetcdf-dev
sudo apt install libglu1-mesa-dev freeglut3-dev mesa-common-dev

# aws cli

Following  https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

## aws-cdk

Needs nodejs first

```
VERSION=v14.15.5
DISTRO=linux-x64
sudo mkdir -p /usr/local/lib/nodejs
sudo tar -xJvf node-$VERSION-$DISTRO.tar.xz -C /usr/local/lib/nodejs 


The add to .basrc
VERSION=v14.15.5
DISTRO=linux-x64
export PATH=/usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin:$PATH
```

```
sudo npm -g install aws-cdk

```

# rsudio

sudo apt install gdebi-core
wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.4.1103-amd64.deb
sudo gdebi rstudio-1.4.1103-amd64.deb

# start up rstudio and run script for package install

```

### Rstudio configs

- apply custom theme
- set https://packagemanager.rstudio.com/all/__linux__/focal/latest as primary cran repo





