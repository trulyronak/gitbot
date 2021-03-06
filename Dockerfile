FROM node:latest

# Install Optic (Can later be reduced to be npm i -g @useoptic/ci-cli)
RUN apt update
RUN apt install apt-transport-https curl git sudo -y
RUN echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
RUN curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
RUN apt update
RUN sudo apt-get install sbt -y
RUN git clone https://github.com/opticdev/optic /home/node/optic
WORKDIR /home/node/optic
RUN git checkout feature/spec-publisher
RUN /bin/bash -c "source ./sourceme.sh && optic_build"

# Install Ruby and setup PR Commenting
RUN \
  apt-get update && \
  apt-get install -y ruby

RUN gem install octokit

COPY comment.rb /home/node/comment.rb

WORKDIR /home/node
COPY entrypoint.sh /home/node/entrypoint.sh
ENTRYPOINT ["/home/node/entrypoint.sh"]