---
title: "The Pain of Developing a Xamarin App for OSX and iOS"
date: 2017-01-09T23:00:00+01:00
draft: false
tags: ["c#", "osx", "dotnet", "xamarin"]
author: ["darren"]
---

When developing applications for Windows, even Windows 10 or some flavour of Linux or BSD, you pretty much have free reign over what you want to do. When it comes to Android, iOS and Mac OSX, it is a different story.
<!--more-->
Well not exactly with OSX, that is more of a recent addition (restriction) in Sierra.

I have spent the last five weeks bootstrapping and building a client application using xamarin on Mac OSX. I chose to use El Capitan, as that was what I could get to run on the hackintosh.

Everything was running well until today, when we had a new starter who came in with a brand-new MacBook running Sierra. We set up the build environment, we set up the extras that were required, built the solution and everything was fine.

Until, we tried to run the application that had been built from the solution. First, there was an immediate crash when the application attempted to load ```System.Reflection.Emit.DynamicMethod```, which didn’t exist on the platform, even though it did. It turns out that even though the file exists, it is not compatible with the new security settings in Sierra. There is a way to disable the use of dynamic code generation, which is to tell Ninject (our DI library) to use reflection, rather than code generation.

Once we got past this, we then got an almost immediate crash while attempting to load ```System.Reflection.Emit.ILGenerator```, which given that we are using reflection, not code generation, we should not be loading any code generation libraries at all. But the main Ninject library references them and requires them.

In the midst of this, another team began prototyping an iOS app with xamarin, and ran into a very similar issue, though this was easily solved with setting ninject to use reflection.

With the OSX app, the solution ended up being, *switching from the Xamarin.Mac Mobile framework, to the Xamarin.Mac .NET 4.5 framework*, which then allowed for much more compatibility with ninject and some of our other libraries.

It turns out, the route cause of all of this, is the operating system’s kernel. Neither like code generation, and iOS outright bans it. I couldn’t tell you why Seirra does not like code generation, but it does not.

**Lesson learned:** use the full framework with the largest feature set, rather than the minimal framework with the reduced feature set for negligible performance gains. Computers are fast, very fast, these days... No need to skimp.

