---
title: "Easy (and complex) Search and Replace in Linux Command Line"
date: 2011-08-15T23:00:00+01:00
draft: false
tags: ["linux", "bash", "find", "replace", "perl"]
author: ["darren"]
---
I wanted to search and replace every file in a directory tree and find a URL that linked to /web-design and remove that part of the URL, and i also wanted to find the phrase "Web Design" in a link and replace it with "Affordable Web Design".

Usually i would have to go through each individual file via SSH or FTP and then open the file, make the edits, save the file and re-upload the file. The problem with that is, i needed to do this for over 15,000 files on over 3000 web sites, and that isn’t something i wanted to do.
<!--more-->
Firstly, i needed to find all the html files that could possibly have these two defects, so i went with "find", its simple, and easy, and crawls sub directories as default.

Find all files with the extension ".html" in the current directory and all sub directories:
```sh
find . -iname '*.html'
```
The problem i had then was, web sites that are still being worked on are in a private directory that i do not want to alter, so i needed to exclude these directories:
```sh
find . -iname '*.html' -not -path '*private*'
```
This now gives me a list of everything that i need to do a search and replace on.

For this next part, you can use either "sed" or "perl". I chose to go with perl as i know perl better than sed.

This cold should replace "/web-design" with "" in a file called "index.html" in the current folder. (Follows the format "s/what to find/what to replace with/g"):
```sh
perl -pi -w -e 's/\/web-design//g;' index.html
```
So what we need to do now is use xargs to combine the two parts and make the search and replace in all files:
```sh
find . -iname '*.html' -not -path '*private*' | xargs perl -pi -w -e 's/\/web-design//g;' -sl
```
This code should now look in the current directory, and all sub-directories contained within for any html file not in a private folder, and remove the text "/web-design" and replace it with nothing.

The next bit was a simple modification to replace the phrase "Web Design" with "Affordable Web Design", though we needed to take into account that we only wanted to replace content within a A HREF tag, so we need to search for ">Web Design<"
```sh
find . -iname '*.html' -not -path '*private*' | xargs perl -pi -w -e 's/\>Web Design\</\>Affordable Web Design\</g;' -sl
```
Make sure that when you are creating your regular expressions, you escape any special characters such as \ / < > and friends