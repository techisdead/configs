#!/bin/bash
## Run this as sudo - prior to running 
## sudo su

# update from https://www.rstudio.com/products/rstudio/download/#download
RSTUDIO_URL=https://download1.rstudio.org/desktop/jammy/amd64
RSTUDIO_PKG=rstudio-2022.07.2-576-amd64.deb

source /etc/lsb-release

apt install --yes --no-install-recommends wget ca-certificates
$ sudo apt -y install gdebi-core


## subversion
apt install subversion


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


## Rstudio
wget $(RSTUDIO_URL)/$(RSTUDIO_PKG)
sudo apt install -f -y ./$(RSTUDIO_PKG)
rm ./$(RSTUDIO_PKG)



