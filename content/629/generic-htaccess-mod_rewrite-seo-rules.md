---
title: "Generic htaccess mod_rewrite SEO rules"
date: 2010-11-30T23:00:00+01:00
draft: false
tags: ["apache", "http"]
author: ["darren horrocks"]
---

this little strip of code will make sure you always have a WWW and will make sure that you dont have / and index as two seperate pages.

<!--more-->

```text
RewriteEngine on
RewriteCond %{HTTP_HOST} !^www
RewriteRule (.*) http://www.%{HTTP_HOST}/$1 [L,R=301]

Options +FollowSymLinks
RewriteCond %{THE_REQUEST} ^.*/index.php
RewriteRule ^(.*)index.php$ http://%{HTTP_HOST}/ [R=301,L]

RewriteCond %{THE_REQUEST} ^.*/index.htm
RewriteRule ^(.*)index.htm$ http://%{HTTP_HOST}/ [R=301,L]

RewriteCond %{THE_REQUEST} ^.*/index.html
RewriteRule ^(.*)index.html$ http://%{HTTP_HOST}/ [R=301,L]
```
