---
title: "Building a site with Hugo, using GitHub, Amazon S3 and CloudFront with HTTPS and extensionless URLs"
date: 2019-11-21T09:00:00Z
draft: true
tags: ["blog", "hugo", "github", "aws", "s3", "cloudfront", "https", "devops"]
---

This blog, and many others, are hosted using Amazon AWS. This one has a difference, it is almost completely free to host (and was completely free for the first year) because of Hugo, Amazon S3, Cloudfront, Azure DevOps and (optionally) GitHub.
<!--more-->
This site is built using [hugo](https://gohugo.io/), which is a "website generator" tool that lets you write your pages using markdown, and attach a theme to it, and generates a static html website with SEO friendly (optional) extensionless URLs.

Once the hugo website is set up (which there are plenty of tutorials for on the internet, which I wont rehash here), turn your hugo directory into a git repository.

```cmd
cd [path to hugo site dir with config.toml]
git init .
```

Once you have done this, create a GitHub repository, and add the GitHub remote repository and push your code to GitHub.

```cmd
git remote add origin https://github.com/UserName/Repository.git
git push -u origin master
```

Next, you want to create a free [Azure DevOps](https://azure.microsoft.com/en-us/services/devops/) account and link it to GitGub.

Create a new build pipeline in Azure DevOps with the agent specification of "windows-2019". Set "Get Sources" to GitHub and choose the repository that we set up earlier, and choose "master" as the branch.
