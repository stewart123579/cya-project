#!/bin/sh

# Ensure the metadata directory exists
mkdir -p $(grep '^metadata' ~/.offlineimaprc | sed 's/^.* = //')

# Get the email
offlineimap.py
