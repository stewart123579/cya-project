FROM v4tech/base:latest
MAINTAINER Stewart V. Wright <stewart@vifortech.com>

# v4tech/base has all the git, ca-certs, etc. installed already.

RUN apt-get update
# && \
RUN \
    apt-get install -y --no-install-recommends \
        file \
        python-debian
# && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash mymail
WORKDIR /home/mymail
USER mymail

RUN mkdir /home/mymail/bin
ENV USER mymail
ENV HOME /home/mymail
ENV PATH /home/mymail/bin:${PATH}

# Now install the latest offlineimap locally...
RUN cd /home/mymail && \
    git clone https://github.com/OfflineIMAP/offlineimap.git && \
    cd offlineimap && \
    git checkout $(git tag | grep -v rc | tail -1)  && \
    ln -s /home/mymail/offlineimap/offlineimap.py /home/mymail/bin/offlineimap.py

# Install the Gmail OAuth2 tools
RUN cd ~ && \
    git clone https://github.com/google/gmail-oauth2-tools
