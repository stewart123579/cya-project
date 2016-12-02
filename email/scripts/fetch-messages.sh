#!/bin/sh

# Ensure the metadata directory exists
mkdir -p $( grep '^metadata' ~/.offlineimaprc | sed 's/^.* = //' | sed "s=~=$HOME=" )

# Get the email
offlineimap "$@"
