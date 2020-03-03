#!/bin/bash

echo "### Welcome to Google Cloud Shell Auto Deploy Script ###"

USER=`whoami`

if [[ $USER == "root" ]]
then
  echo "Plase run as normal user!"
  exit
fi

#get .local
git clone https://github.com/guleonseon/gcs-auto.git

#copy .local .bashrc to $HOME
cp gcs-auto/.local $HOME

if [[ -f $HOME/.bashrc ]]
then
  mv $HOME/.bashrc $HOME/.bashrc_bak
fi

cp gcs-auto/.bashrc $HOME

source $HOME/.bashrc

echo "Deploy has all done, enjoy it!"

