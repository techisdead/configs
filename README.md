# configs
dotfiles and configs


## first install

The following lines install some basics then download this repo

```bash

sudo apt update && sudo apt upgrade

sudo apt-get install build-essential
sudo apt install git

sudo apt-get install libsecret-1-0 libsecret-1-dev
cd /usr/share/doc/git/contrib/credential/libsecret
sudo make
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret

```

This sets up github and also the libsecret library to store an encryped access token for github.  That’s all, next time you try to commit or push you will have to get yourself a Github PAT (Settings -> Developer Settings -> PErsonal Access Token). Enter the PAT instead of your password. It will be automagically saved in your credential library and accessible in the future.

Set up git folders, e.g.

```bash

cd ~/
mkdir repos
cd repos
git clone https://github.com/techisdead/configs.git
cd configs

# You may want to run the following line by line...
#source firstinstall.sh 
```
