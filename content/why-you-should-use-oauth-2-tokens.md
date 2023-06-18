---
title: "Why You Should Use Oauth OAuth 2.0 Tokens"
date: 2022-04-14T21:25:28+01:00
draft: false
tags: ["auth","oauth","web","services"]
author: ["darren horrocks"]
---

An OAuth 2.0 access token is usually a base64 encoded string that the client uses when making requests to the server, and can hides the user's identity and other personal information from the client app/website and anybody listening in on the line.

<!--more-->

Access tokens expire after a certain amount of time and become invalid and cannot be used for any API request after the expiration date/time. If offline access is requested to the for the token, you can refresh an access token without prompting the user for permission, even when the user is not present.

It is best to set the expiration time for refresh token longer than the expiration of the access tokens its self. For example, if you set the expiration for the access token to 30 minutes, set the refresh token's expiration to 24 hours or more (depending on when you expect a user to next use the service).

Some apps may request that the user reauthenticate after a shorter period of time, which relies on the access token alone rather than a refresh token. These apps have online access as opposed to those that have a refresh token and are considered to have offline access.
