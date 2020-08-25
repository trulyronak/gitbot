#!/bin/bash -l

git clone https://github.com/$1 repoName
cd repoName
git checkout $2
export OPTIC_LOCAL_CLI__API_GATEWAY=https://staging.infra.opticdev.com
export OPTIC_LOCAL_SPEC_VIEWER_URL=https://apidocs.o3c.info
export MESSAGE=$(/home/node/optic/workspaces/ci-cli/bin/run publish)
echo "::set-output name=message::$MESSAGE"