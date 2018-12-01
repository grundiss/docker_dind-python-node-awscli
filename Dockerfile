FROM gitlab/dind

RUN apt-get update && apt-get install -y curl python python-pip
RUN pip install awscli
RUN curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash - \
    && sudo apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \
    && sudo apt-get update && sudo apt-get install -y yarn

