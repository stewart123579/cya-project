FROM python:3-slim
MAINTAINER Stewart V. Wright <stewart@vifortech.com>

# If there are security updates for any of the packages we install,
# bump the date in this environment variable to invalidate the Docker
# build cache and force installation of the new packages.  Otherwise,
# Docker's image/layer cache may prevent the security update from
# being retrieved.
ENV SECURITY_UPDATES="2018-08-08" 

# Put all this in one command to make the image smaller...
RUN pip install requests \
    && apt-get -qq update \
    && apt-get install -y --no-install-recommends wget \
    && rm -rf /var/lib/apt/lists/* \
    && wget https://raw.githubusercontent.com/amikeal/hipchat_export/master/hipchat-export.py \
    && chmod u+x hipchat-export.py \
    && apt-get remove -y wget \
    && apt-get autoremove -y \
    && apt-get clean

ENTRYPOINT ["/hipchat-export.py"]
CMD ["--help"]
