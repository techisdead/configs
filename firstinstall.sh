#!/bin/bash
## Run this as sudo - prior to running 
## sudo su

# update from https://www.rstudio.com/products/rstudio/download/#download

RSTUDIO_PKG='https://download1.rstudio.org/electron/jammy/amd64/rstudio-2023.12.1-402-amd64.deb'

ZOOM='https://zoom.us/client/6.0.0.4563/zoom_amd64.deb'
OBSIDIAN='https://github.com/obsidianmd/obsidian-releases/releases/download/v1.5.12/obsidian_1.5.12_amd64.deb'
SLACK='https://downloads.slack-edge.com/desktop-releases/linux/x64/4.37.101/slack-desktop-4.37.101-amd64.deb'
ZOTERO='https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64&version=6.0.35'
RSTUDIO='https://download1.rstudio.org/electron/jammy/amd64/rstudio-2023.12.1-402-amd64.deb'
VSCODE='https://code.visualstudio.com/download#'


source /etc/lsb-release

apt install --yes --no-install-recommends \
  wget \
  ca-certificates \
  gdebi-core \
  curl


## subversion
apt install subversion

## sublime text

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg \
  | gpg --dearmor \
  | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" \
 | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

## install nice things
mkdir ~/.sources && mv ./install.sh ~/.sources && cd ~/.sources
chmod u+x install.sh

./install.sh zoom $ZOOM
./install.sh obsidian $OBSIDIAN
./install.sh obsidian $OBSIDIAN
./install.sh slack $SLACK

# zotero needs more steps
wget $ZOTERO -O zotero.tar.bz
tar xfv zotero.tar.bz -C /opt/

/opt/Zotero_linux-x86_64/set_launcher_icon 
ln -s /opt/Zotero_linux-x86_64/zotero.desktop ~/.local/share/applications/zotero.desktop

# tailscale

curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg \
  | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null

curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list \
 | sudo tee /etc/apt/sources.list.d/tailscale.list

apt update && apt install tailscale
tailscale up

# Spotify

curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg  | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free"  \
  | sudo tee /etc/apt/sources.list.d/spotify.list
apt update && apt install spotify


## R
### https://cran.r-project.org/bin/linux/ubuntu/
apt install --no-install-recommends software-properties-common dirmngr
# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

apt update
apt install --no-install-recommends r-base r-base-dev

## r2u to enable ubuntu binaries ++ dependancies
### https://github.com/eddelbuettel/r2u


wget -q -O- https://eddelbuettel.github.io/r2u/assets/dirk_eddelbuettel_key.asc \
    | tee -a /etc/apt/trusted.gpg.d/cranapt_key.asc

echo "deb [arch=amd64] https://dirk.eddelbuettel.com/cranapt $(lsb_release -cs) main" \
    > /etc/apt/sources.list.d/cranapt.list
apt update

## Fourth: add pinning to ensure package sorting
echo "Package: *" > /etc/apt/preferences.d/99cranapt
echo "Pin: release o=CRAN-Apt Project" >> /etc/apt/preferences.d/99cranapt
echo "Pin: release l=CRAN-Apt Packages" >> /etc/apt/preferences.d/99cranapt
echo "Pin-Priority: 700"  >> /etc/apt/preferences.d/99cranapt

Rscript -e 'install.packages("bspm")'
export RHOME=$(R RHOME)
echo "suppressMessages(bspm::enable())" >> ${RHOME}/etc/Rprofile.site


## Rstudio
wget $RSTUDIO_PKG
gdebi ./$RSTUDIO_PKG




