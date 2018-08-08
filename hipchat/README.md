# CYA - Email

Part of the CYA Project : [https://github.com/stewart123579/cya-project](https://github.com/stewart123579/cya-project)

## Hipchat

Hipchat is **[dead](https://techcrunch.com/2018/07/26/atlassians-hipchat-and-stride-to-be-discontinued-with-slack-buying-up-the-ip/)**.  Hip hip hooray.

Also - did you know that when someone _leaves_ your organisation, all the personal (1-1) chats vanish too?

Download them all now.



## *tl;dr* - For the extra lazy...
- Pull the docker image:

``` shell
docker pull v4tech/cya-hipchat
```

- Get your API key

  - Open your account API page:  `https://MYCOMPANY.hipchat.com/account/api`
  - Create a new API token with the Scopes:
    - `View Group`;
    - `View Messages`;
    - `View Room`
  - Take a copy of the token (it's the long random string)

- What commands to run?  Get `help`
```
docker run --rm v4tech/cya-hipchat
```

- Download all your messages (in JSON)

``` shell
docker run --rm v4tech/cya-hipchat -u abcd1232... > all.messages.json
```


---

## Thanks

Don't forget to thank Adam Mikeal for the [hipchat_export](https://github.com/amikeal/hipchat_export) code.
