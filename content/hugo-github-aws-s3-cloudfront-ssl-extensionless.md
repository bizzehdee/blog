---
title: "Building a site with Hugo, using GitHub, Amazon S3 and CloudFront with HTTPS and extensionless URLs"
date: 2020-10-08T08:00:00Z
draft: true
tags: ["blog", "hugo", "github", "aws", "s3", "cloudfront", "https", "devops"]
author: ["darren"]
---

This blog, and many others, are hosted using Amazon AWS. This one has a difference, it is almost completely free to host (and was completely free for the first year) because of Hugo, Amazon S3, Cloudfront, lambda@edge, Azure DevOps and (optionally) GitHub.
<!--more-->
This site is built using [hugo](https://gohugo.io/), which is a "website generator" tool that lets you write your pages using markdown, combine that markdown with a theme, and generates a static html website with SEO friendly (optional) extensionless URLs.

Once the hugo website is set up ([use the hugo quick start](https://gohugo.io/getting-started/quick-start/)), turn your hugo directory into a git repository.

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

Save this YAML file and run a build, you should see that your markdown is pulled from github, and then devops generates your site for you, and uploads it to container storage named "content" within azure devops. A new build will be automatically run each time a commit is made to your master branch within github.

