#!/bin/bash -l

# Clone the Repo and get the base and head specification files
git clone https://github.com/$1 repoName
cp .optic/api/specification.json /tmp/base.json
cd repoName
git checkout $2
cp .optic/api/specification.json /tmp/head.json

# START — Only required for development mode
export OPTIC_LOCAL_CLI__API_GATEWAY=https://staging.infra.opticdev.com
export OPTIC_LOCAL_SPEC_VIEWER_URL=https://apidocs.o3c.info
# END — Only required for development mode

# Run ci publish to get the specUrl
export URL=$(/home/node/optic/workspaces/ci-cli/bin/run publish --url)

# Run ci compare to generate the markdown diff + formatted for the PR
/home/node/optic/workspaces/ci-cli/bin/run compare /tmp/base.json /tmp/head.json --specUrl $URL > /tmp/message

# Comment on the PR
ruby /home/node/comment.rb /tmp/message false
