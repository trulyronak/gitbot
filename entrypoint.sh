#!/bin/sh -l

apt update
apt install sudo -y
sudo apt-get update
sudo apt-get install apt-transport-https -y
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
sudo apt-get update
sudo apt-get install sbt -y
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
git clone https://github.com/opticdev/optic
cd optic
git checkout feature/spec-publisher
. ./sourceme.sh && optic_build
cd ..
git clone https://github.com/$1 repoName
cd repoName
git checkout $2
export MESSAGE=$(cidev publish)
echo $MESSAGE
echo "::set-output name=message::$MESSAGE"
