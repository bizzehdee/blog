---
title: "What's New and Interesting in .NET 5"
date: 2020-10-15T21:52:13+01:00
draft: false
author: ["darren"]
tags: ["dotnet", "core", "net5", "vNext"]
---

Microsoft recently announced .NET 5 (dotnet5) which is the unification of .NET Framework and dotnet core, leaving behind the divergance, and unifying the whole .NET platform.
<!--more-->

## Why .NET 5 and not dotnet core 4.0

Given that Microsoft have already released .NET Framework 4.0 several years ago, they decided the best idea would be to skip the 4.0 release with dotnet core to avoid confusing users (which they did for sort of the same reason in Windows 10), and they landed on .NET 5.0, unifying the names and the numbers from Framework and core.

## The Unified Platform

.NET 5 will be able to target Windows, Linux, macOS, iOS, Android, tvOS, watchOS and WebAssembly. Building on top of dotnet core and the best of mono to create a platform that will allow developers to create apps for multiple operating systems and devices from a single codebase and a single framework.

## Runtime

**CoreCLR** is the runtime that is used in dotnet core, and has been targeted at cloud and web applications, and more recently, desktop applications and IoT devices.

**Mono** is the original cross platform runtime that was designed to be compatible with .NET. It started out as an alternitive, but was later brought into the fold of the mainstream platform and is at the core of Xamarin.

With .NET 5 and .NET 6 in the future, Microsoft aims to have CoreCLR and Mono be fully interchangable with each other, i.e. a .NET application can run the same on either runtime.

## RyuJIT (the assembly code generator)

There are many enhancements in RyuJIT, such as enabling the [suppression of some bounds checks](https://github.com/dotnet/runtime/pull/36263), [tail duplication improvements](https://github.com/dotnet/runtime/pull/37038) and [removal of redundant zero inits](https://github.com/dotnet/runtime/pull/37786). RyuJIT also implements [ARM64 hardware intrinsics](https://github.com/dotnet/runtime/issues/33308), creating smaller and faster code when building for AMD64 targets. 

## Garbage collection

Garbage collection will now expose detailed data on the most recent collection, developers can use the ```GetGCMemoryInfo``` method, which will return a ```GCMemoryInfo``` object. The ```GCMemoryInfo``` object contains information about machine memory, heap memory and the most recent collection, or the most recent specified collection such as: ephemeral, full blocking, or background. The main use for this would be logging/monitoring and to communicate to a load balancer that a machine should be taken out of rotation.

## System.Text.Json

The new System.Text.Json allows the user the ability to ignore default values for value type properties when serializing, reducing resource costs (both CPU and network), this is a breaking change for System.Text.Json, but is a welcome change. System.Text.Json also has ways of dealing with circular references when serializing.

## What else?

When .NET 5 hits production release in november 2020, we expect to see cross platform support (full or partial) for:

* ASP.NET Core, an open source framework for web applications.
* Entity Framework Core data access technology.
* WinForms.
* WPF (Windows Presentation Foundation).
* Xamarin mobile app device model.
* ML.NET.

As well as:

* C# 9 and F# 5 language support
* Improved HTTP 1.1 and HTTP 2 performance
* Single file applications (linking all assemblies into a single exe)

Take a look at the [microsoft dotnet](https://dotnet.microsoft.com/) website for downloads and more information.