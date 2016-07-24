#!/bin/sh

cd ~
python gmail-oauth2-tools/python/oauth2.py \
    --generate_oauth2_token \
    --client_id=$(grep -m 1 oauth2_client_id .offlineimaprc | sed 's/^.* = //') \
    --client_secret=$(grep -m 1 oauth2_client_secret .offlineimaprc | sed 's/^.* = //')
