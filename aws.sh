#!/bin/sh


# see https://github.com/nvm-sh/nvm 
NVM_URL=https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh

# if you need nvm install

wget -q0- $(NVM_URL) | bash

# get latest node
nvm install node

# get aws-cli

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

## cdk

npm install aws-cdk --location=global