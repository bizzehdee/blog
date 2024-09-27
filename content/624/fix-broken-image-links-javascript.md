---
title: "Fix broken image links with javascript"
date: 2010-11-30T23:00:00+01:00
draft: false
tags: ["html", "javascript"]
author: ["darren horrocks"]
---

When you have large scale websites that span many servers, sometimes servers go down, and you get a missing image, even if the server is up, you can get corruption loading to a broken image that does not display correctly. This piece of javascript aims to fix broken images on each page load, giving an overall more profesional look. Quite simply, the javascript adds a hook into each image and checks to see if the image has loaded properly or not, and if not, a replacment images is put there instead to make sure that the missing image is auto-fixed for you and the site does not have any missing images.

<!--more-->

### step 1. 

add this piece of code as the very last thing before the body close tag within a ```<script>``` tag

```javascript
  var i = 0;
  var img = new Image();
  for (i = 0; i < document.images.length; i++) {
    img = document.images[i];
    img.onerror = function (evt) {
      this.src = "soon.gif";
    }
  };
```

### step 2. 

“soon.gif” image and drop it within the same directory as the file that is using the script (i.e. the root web directory)

now you will notice that when you have missing images within the site, they will now be replaced by “soon.gif”.

**Notes.** you can put the replacement image within a directory and use any filename you wish as long as you reflect the changes within the javascript
