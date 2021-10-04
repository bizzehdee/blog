---
title: "Building a site with Hugo, using GitHub, Amazon S3 and CloudFront with HTTPS and extensionless URLs"
date: 2021-03-10T08:00:00Z
draft: true
tags: ["blog", "hugo", "github", "aws", "s3", "cloudfront", "https", "devops"]
author: ["darren"]
---

This blog, and many others, are hosted using Amazon AWS. This one has a difference, it is almost completely free to host (and was completely free for the first year) because of Hugo, Amazon S3, Cloudfront, lambda@edge, Azure DevOps and (optionally) GitHub.
<!--more-->
This site is built using [hugo](https://gohugo.io/), which is a "website generator" tool that lets you write your pages using markdown, combine that markdown with a theme, and generates a static html website with SEO friendly (optional) extensionless URLs.

You first need to set your local copy of your hugo website, ([use the hugo quick start](https://gohugo.io/getting-started/quick-start/)) and add some content/posts.

Now the hugo site is set up, and you have started adding content, we need somewhere to put the site that hugo generates, this is where amazon s3 comes in.

If you do not already have one, sign up for an amazon aws account (its free to sign up).

In your aws account, you will need to create an s3 bucket, and the name of the bucket should be the exact domain name you intend to use as your website domain name, the region would be best to be a region close to you, but as long as its on the same continent, it doesnt really matter. Under "set permissions" you need to uncheck "block all public access" and uncheck all its child check boxes too. Once created, go to properties > static website hosting and unable "use this bucket to host a website", set the index document to index.html and the error document to error.html and save. This should now give you an amazon s3 url to your bucket. If you upload a temporary index.html document, you should now be able to visit the s3 url and see the index page.

![s3 bucket hosting config][example1]

To have the website automatically built and deployed to your s3 bucket, you will need to set up a git repository (at github, or azure devops).

```cmd
cd [path to hugo site dir with config.toml]
git init .
```

Once you have done this, create a GitHub repository, and add the GitHub remote repository and push your code to GitHub.

```cmd
git remote add origin https://github.com/UserName/Repository.git
git push -u origin master
```

Next, you want to create a free [Azure DevOps](https://azure.microsoft.com/en-us/services/devops/) account and link it to GitGub. Next, you will want to add the "hugo" and the "aws toolkit for azure devops" extensions to your azure devops account.

Now, create a new build pipeline in Azure DevOps with the agent specification of "windows-2019". Set "Get Sources" to GitHub and choose the repository that we set up earlier, and choose "master" as the branch.

Then you want your build YAML file to look something like this (vmImage needs to be windows as Hugo in devops does not yet support linux images):

```yml
trigger:
- master

pool:
  vmImage: 'windows-latest'

steps:
- checkout: self
  submodules: true
  clean: true
- task: HugoTask@1
  displayName: Generate Site
  inputs:
    source: '$(Build.SourcesDirectory)'
    destination: '$(Build.ArtifactStagingDirectory)'
    baseURL: 'https://mysite.com/'

- task: PublishBuildArtifacts@1
  inputs:
    PathtoPublish: '$(Build.ArtifactStagingDirectory)'
    ArtifactName: 'content'
    publishLocation: 'Container'
```

Save this YAML file and run a build, you should see that your markdown is pulled from github, and then devops generates your site for you, and uploads it to container storage named "content" within azure devops (be sure that the baseURL matches your baseURL in your hugo config). A new build will be automatically run each time a commit is made to your master branch within github.

***Option 1: (Hosted directly on s3 with no SSL)***

If you do not want to go through the extra steps of having SSL, and you only want to set up a single website domain, then all you need to do is get your s3 domain from the s3 website setup step, and create a CNAME from the domain (same domain you named the bucket) to the s3 domain.

i.e. ```www.mysite.com -> CNAME -> www.mysite.com.s3-website-eu-west-1.amazonaws.com``` (depending on your region that you chose).

Once the new domain has resolved correctly, you are done.

***Option 2: (Hosted on s3 with cloudfront and SSL and optionally, multiple domains)***



[example1]: /images/s3-bucket-hosting-1.png "s3 bucket hosting config"