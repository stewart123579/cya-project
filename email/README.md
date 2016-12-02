# CYA - Email

## Offline email tools

**Goals**

| Goal                                                                                             | Done               | *tl;dr*                                 |
| :---                                                                                             | :-:                | :---                                    |
| I want to be able to backup my cloud based email to a local machine - **using OAuth2**           | :white_check_mark: | [OfflineIMAP](#offlineimap) below       |
| I want to be able to send email from my local machine - **using OAuth2**                         | :white_check_mark: | [send.py](#send.py) below               |
| I will **not** use passwords or turn on *"Allow insecure apps"* - I will use OAuth2 (or better!) | :white_check_mark: |                                         |
| I want to be able to search and read messages whilst offline                                     | :white_check_mark: | see [notmuch](https://notmuchmail.org/) |
| I want to be be able to reply to my email when I'm offline (i.e. queue)                          | :white_check_mark: | [msmtpq](#msmtpq) below                 |



## *tl;dr* - For the extra lazy...
- Pull the docker image:

``` shell
docker pull v4tech/cya-email
```

- Source the wrapper functions:

``` shell
wget https://raw.githubusercontent.com/v4tech/cya-with-docker/master/cya-dockerfunc.sh
source cya-dockerfunc.sh
```

- Profit!  &nbsp; &nbsp;  :dollar: :moneybag:
  - `offlineimap`
  - `send.py` pretending to be `msmtp`
  - `msmtpq`



## OfflineIMAP
OAuth2 aware email sync - [www.offlineimap.org](http://www.offlineimap.org/)

Mapped as command `offlineimap`

#### Docker command
``` shell
docker run --rm \
    --name email 
    -v ${HOME}/offlineimap.conf:/home/mymail/.offlineimaprc:ro \
    -v ${HOME}/Mail:/home/mymail/Mail \
    v4tech/cya-email \
    fetch-messages.sh
```
- You can set this up as a cron job to run regularly...
- Email is downloaded to your (host) ~/Mail
- Link to a [sample offlineimaprc](FIXME) file



## send.py
OAuth2 aware email sending - [https://github.com/cscorley/send.py][send.py.github]

Mapped as commands `send.py` and (wrapper) `msmtp` 

This section is only really useful if you want to send a message *now*.  For queueing and sending later see the [msmtpq](#msmtpq) section below.

#### Docker command
**NOTE**: I've written a wrapper called `msmtp` to make this interact with `msmtpq` transparently.

``` shell
docker run --rm -i \
    -v ${HOME}/sendpyrc:/home/mymail/.sendpyrc:ro
    v4tech/cya-email \
    msmtp
```
- An [example .sendpyrc](https://github.com/cscorley/send.py/blob/master/sendpyrc-example) file

#### Example: sending a message
Look at the [example given by Christopher Corley](http://christop.club/2014/01/19/sup/#running-1), but **remember** to change his `send.py --readfrommsg` to `msmtp`.

> Test your email by doing this (change the email addresses first, silly):
``` shell
echo "From: Christopher S. Corley <cscorley@gmail.com>
To: Test <test@example.com>
Subject: Test message
`
Body would go here
" | msmtp
```



## msmtpq
Message queue for msmtp - [https://github.com/project-mir/mir.msmtpq](https://github.com/project-mir/mir.msmtpq)

Mapped as command `msmtpq`

I'm cheating and using `msmtpq` to queue messages to send with `send.py`.  In JVR's [post][jvr.oauth2] he mentions patching `mir.msmtpq`, but I've just added a wrapper script.

#### Docker command
``` shell
docker run --rm -i \
    -v ${HOME}/sendpyrc:/home/mymail/.sendpyrc:ro \
    -v ${HOME}/msmtpq-queue:/home/mymail/.config/msmtpq/queue \
    v4tech/cya-email \
    msmtpq
```
- Messages are queued in (container) `~/.config/msmtpq/queue`.  Remember to mount this externally.

#### Example: queueing then sending a message
Queue a message:
``` shell
echo "From: Christopher S. Corley <cscorley@gmail.com>
To: Test <test@example.com>
Subject: Test message

Body would go here
" | msmtpq
```
Check the queue:
``` shell
msmtpq --manage list
```
See...it's there...
```
Key: 920cce313eb9095a463f00a7b711d1a224756879
Args: []
From: Christopher S. Corley <cscorley@gmail.com>
To: Test <test@example.com>
Subject: Test message

Body would go here
```

So then send it:
``` shell
msmtpq --manage send
```



## TO DO
Things I still need to do - or creat links to solutions elsewhere:
- Explain the creation of OAuth2 tokens
- Add in some sample config files
- CI testing



---
---
## Aside for non-Un\*x systems
You'll have to work out what `${HOME}/sendpyrc`, etc.,  means in your system.  I don't do Windows.



---
---
## Some links

### OAuth2 authentication
- Prof. Jayanth R Varma's (JVR) post on [OAuth2 authentication for (offline) email clients][jvr.oauth2]
- JVR's post that [explains his *"Head in the clouds, feet on the ground"* philosophy][jvr.philosophy.1] - and is almost exactly the same as mine!
- Christopher Corley's [send.py GitHub][send.py.github] and [blog post][send.py.blog]


---
[send.py.blog]: http://christop.club/2014/01/19/sup/
[send.py.github]: https://github.com/cscorley/send.py
[jvr.philosophy.1]: https://jrvcomputing.wordpress.com/2015/06/16/head-in-the-cloud-feet-on-the-ground-part-i-email-2/
[jvr.oauth2]: https://jrvcomputing.wordpress.com/2016/11/21/oauth2-authentication-for-offline-email-clients/

