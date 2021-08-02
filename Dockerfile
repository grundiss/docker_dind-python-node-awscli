FROM ubuntu:20.04

# Let's start with some basic stuff.
RUN apt-get update -qq && \
    apt-get install -qqy apt-transport-https ca-certificates curl lxc iptables gnupg unzip dmsetup

RUN curl -sSL https://get.docker.com/ | sh

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

RUN apt-get update && apt-get install -y docker-ce nodejs yarn google-cloud-sdk kubectl

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install
RUN curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

ENV LOG=file

# Define additional metadata for our image.
VOLUME /var/lib/docker
CMD ["wrapdocker"]
