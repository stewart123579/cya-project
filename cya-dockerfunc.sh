#!/bin/sh
#
# Wrapper functions for CYA calls to Docker
set -e

CYA_CONTAINER=v4tech/cya-email
CYA_CONFIG_DIR=${HOME}/work/CYA-config

OFFLINEIMAPCONF=${CYA_CONFIG_DIR}/offlineimap.conf
SENDPYRC=${CYA_CONFIG_DIR}/sendpyrc
MSMTPQ_QUEUE=${CYA_CONFIG_DIR}/msmtpq-queue


msmtpq() {
    mkdir -p ${MSMTPQ_QUEUE} && \
    docker run --rm -i \
        -v ${SENDPYRC}:/home/mymail/.sendpyrc:ro \
        -v ${MSMTPQ_QUEUE}:/home/mymail/.config/msmtpq/queue \
        ${CYA_CONTAINER} \
        --name cya-msmtpq \
        msmtpq "$@"
}


msmtp() {
    docker run --rm -i \
        -v ${SENDPYRC}:/home/mymail/.sendpyrc:ro \
        ${CYA_CONTAINER} \
        --name cya-msmtp \
        msmtp "$@"
}


offlineimap() {
    docker run --rm -i \
        -v ${OFFLINEIMAPCONF}:/home/mymail/.offlineimaprc:ro \
        -v $HOME/notmuch-mail:/home/mymail/Mail \
        ${CYA_CONTAINER} \
        --name cya-offlineimap \
        fetch-messages.sh "$@"
}
