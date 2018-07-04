FROM gitlab/dind

RUN apt-get update && apt-get install -y curl \
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python get-pip.py \
    && pip install awscli \
    && curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash - \
    && sudo apt-get install -y nodejs

