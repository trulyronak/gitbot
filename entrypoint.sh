#!/bin/bash -l

git clone https://github.com/$1 repoName
# we currently have base
cp .optic/api/specification.json /tmp/base.json
cd repoName
git checkout $2
cp .optic/api/specification.json /tmp/head.json
export OPTIC_LOCAL_CLI__API_GATEWAY=https://staging.infra.opticdev.com
export OPTIC_LOCAL_SPEC_VIEWER_URL=https://apidocs.o3c.info
export URL=$(/home/node/optic/workspaces/ci-cli/bin/run publish --url)
/home/node/optic/workspaces/ci-cli/bin/run compare /tmp/base.json /tmp/head.json --specUrl $URL > /tmp/message
export MESSAGE=$(cat /tmp/message)
MESSAGE=$(cat /tmp/message)
MESSAGE="${MESSAGE//'%'/'%25'}"
MESSAGE="${MESSAGE//$'\n'/'%0A'}"
MESSAGE="${MESSAGE//$'\r'/'%0D'}"

# Comment
ruby /home/node/comment.rb /tmp/message false

echo $MESSAGE
echo "::set-output name=message::$MESSAGE"