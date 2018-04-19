#!/bin/bash

sudo apt-get -y update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common python-pip build-essential libltdl3-dev unzip

#Setup and install docker if necessary 
if [[ $(docker -v | cut -d ' ' -f3) == "17.06.2-ce," ]] 
then
  echo -e "Docker up to date\n"
else
  echo -e "*** Setting up and installing docker. ***\n"
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add 
  sudo add-apt-repository "deb [arch=s390x] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get -y update
  sudo apt-get -y install docker-ce=17.06.2~ce-0~ubuntu
  sudo usermod -aG docker bcuser 
  echo -e "*** Done with docker. ***\n"

  echo "Some changes have been made that require you to log out and log back in."
  echo "Please do this now and then re-run this script."
  exit 1
fi

#Setup and install docker-compose if necessary
if [[ $(docker-compose --version | cut -d ' ' -f3) == "1.20.0," ]]
then
  echo -e "Docker-compose up to date\n"
else
  echo -e "*** Installing docker-compose. ***\n"
  sudo pip install docker-compose==1.20.0
  echo -e "*** Done with docker-compose. ***\n"
fi

#Install NodeJS if necessary 
if [[ $(node --version) == "v8.9.4" ]]
then
  echo -e "NodeJS up to date\n"
else
  echo -e "*** install_nodejs ***"
  cd /tmp
  wget https://nodejs.org/dist/v8.9.4/node-v8.9.4-linux-s390x.tar.xz
  cd /home/bcuser && tar --strip-components=1 -xf /tmp/node-v8.9.4-linux-s390x.tar.xz
  echo -e "*** Done withe NodeJS ***\n"
fi

#Get repository for demo if necessary
if [[ $(ls | grep Z-vehicle-demo) ]]
then
  echo -e "1-up, time to give this demo another run\n"
else
  git clone https://github.com/siler23/Z-vehicle-demo.git
  echo -e "1 shot, 1 opportunity\n"
fi

#Setup and launch demo
cd Z-vehicle-demo/packages/vehicle-lifecycle
./build.sh 
cat installers/hlfv11/install.sh | bash
