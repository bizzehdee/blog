---
title: "PHP Problem with UPLOAD_ERR_PARTIAL (File upload error code 3)"
date: 2012-05-01T20:00:00+01:00
draft: false
tags: ["php", "file upload", "headers", "http"]
author: ["darren"]
---

I have just spent the last 3 hours trying to figure out why only ever 3rd file would upload (and then files would only randomly upload) and i continued to get UPLOAD_ERR_PARTIAL. It turns out UPLOAD_ERR_PARTIAL can be caused by the header ```Connection: Keep-Alive.```
<!--more-->
If you are working on a web app that requires a lot of file uploading, make sure to use on your uploader script to set:
```php
header("Connection: close");
```

This will force the connection to be closed, and for a new connection to be opened to upload the file, which allows the file to be properly uploaded.