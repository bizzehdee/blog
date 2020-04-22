---
title: "dotnet core 3.0 Self Contained Single Executable (and other build optimisations)"
date: 2020-04-21T23:36:31+01:00
draft: false
tags: ["dotnet", "core", "c#", "optimisation", "aot", "publish-single-file", "publish-trimmed"]
---

Applications feel more optimised when their binaries, or set of binaries are small. With dotnet core 3.0 there are some features built in that help facilitate this.
<!--more-->

## Specify the build target

First of all, you should specify your build target for your release builds, this will create a binary specifically optimised and targeted for that platform.

A non-exhaustive list of possible runtime targets are: *win-x64, win-x86, win-arm, win-arm64, linux-x64, linux-arm, osx-x64*. (The full list can be found on the microsoft [runtime id catalog](https://docs.microsoft.com/en-us/dotnet/core/rid-catalog))

```cmd
dotnet publish -r win-x64 -c release
```

## Publish Trimmed

Publishing in trimmed mode, the dotnet core compiler attempts to work out which assemblies will actually be used, and which will not, and removes all unused assemblies from the published output.

To do this, you will need to add a single xml block to your csproj file.

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netcoreapp3.0</TargetFramework>
    <PublishTrimmed>true</PublishTrimmed>
  </PropertyGroup>
</Project>
```

Though if your app or library uses reflection in any sort of way, you need to let the tool-chain know that you do not want certain assemblies trimmed (because dotnet is good, but its not THAT good). You would do this by adding a block of XML like the following to your csproj file.

```xml
<ItemGroup>
  <TrimmerRootAssembly Include="System.Data.SqlClient" />
</ItemGroup>
```

## Publish as Single File

Another new option that comes with dotnet core 3.0 is the ability to publish your entire application as a single assembly (exe/dll).

To do this, you will need to the option to your csproj file.

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netcoreapp3.0</TargetFramework>
    <PublishSingleFile>true</PublishSingleFile>
  </PropertyGroup>
</Project>
```

This can be combined with `PublishTrimmed` to produce a very small assemby that contains your application and the required assemblies required to execute the application in a single exe/dll without having to ship the entire dotnet core 3.0 runtime.

## Publish as Ready to Run (AOT)

ReadyToRun is by far the most exciting new option made available in dotnet core 3.0. This isnt simply JITing the MSIL, this is a genuine compilation of as much MSIL to native binary as possible. This is an incredible optimisation if you plan to publish packages on a per-platform basis. This is all as simple as adding the option to your csproj file.

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netcoreapp3.0</TargetFramework>
    <PublishReadyToRun>true</PublishReadyToRun>
  </PropertyGroup>
</Project>
```

If you do have any assemblies that you would like to remain as MSIL in your project for whatever reason (incompatabilities or if the R2R compiler fails) you can exclude any assemblies with the following

```xml
<ItemGroup>
  <PublishReadyToRunExclude Include="AssemblyToExclude.dll" />
</ItemGroup>
```

## Combined

For the best results, it is possible to combine all these options

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netcoreapp3.0</TargetFramework>
    <PublishTrimmed>true</PublishTrimmed>
    <PublishSingleFile>true</PublishSingleFile>
    <PublishReadyToRun>true</PublishReadyToRun>
  </PropertyGroup>
</Project>
```
