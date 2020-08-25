#!/bin/bash -l

echo https://github.com/$1
apt update
apt install sudo -y
sudo apt-get update
sudo apt-get install apt-transport-https curl git -y
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
sudo apt-get update
sudo apt-get install sbt -y

cd /tmp
git clone https://github.com/opticdev/optic optic
cd optic
git checkout feature/spec-publisher

. ./sourceme.sh && optic_build
cd /tmp

git clone https://github.com/$1 repoName
cd repoName
git checkout $2
export OPTIC_LOCAL_CLI__API_GATEWAY=https://staging.infra.opticdev.com
export OPTIC_LOCAL_SPEC_VIEWER_URL=https://apidocs.o3c.info
/tmp/optic/workspaces/ci-cli/bin/run publish  > output
cat output
export MESSAGE=$(cat output)
echo $MESSAGE
echo "::set-output name=message::$MESSAGE"
