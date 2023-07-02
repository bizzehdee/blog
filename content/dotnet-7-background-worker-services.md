---
title: "Creating Windows and Linux background services in dotnet 6.0/7.0"
date: 2023-07-02T22:00:00+01:00
draft: false
tags: ["dotnet", "dotnetcore", "worker", "service", "background", "windows", "linux", "systemd"]
author: ["darren horrocks"]
---

There are times when you need an application to just sit there in the background and deal with the same repetitive task over and over again.

In dotnet core 3.0, a new type of template was introduced, "Worker Service", which is a very easy way of creating Windows Services and Linux Daemons, and it is just as easy in dotnet 6 and 7 (if not, even easier).
<!--more-->

## The Basics

The "worker" template can be accessed in one of two ways:

1. via the command line
```cmd
mkdir myNewWorker
cd myNewWorker
dotnet new worker
```

2. via Visual Studio

![Visual Studio new background worker project example][example1]

[example1]: /images/dotnet-new-worker-figure-1.png "Visual Studio new background worker project example"

Either way, you end up with the same basic template to start with, which is your Startup class, and your Worker class.

## The Startup Class

The startup class is your entry point to the executable
In the initial template, we are

```csharp
public static IHostBuilder CreateHostBuilder(string[] args)
{
    return Host.CreateDefaultBuilder(args)
        .ConfigureServices((hostContext, services) =>
        {
            services.AddHostedService<Worker>();
        });
}
```

The first thing we need to do is add the generic host library nuget package `Microsoft.Extensions.Hosting` and switch the SDK to the worker SDK.

You can do this by opening up your csproj file and making the following changes:

```xml
<Project Sdk="Microsoft.NET.Sdk.Worker">
  <PropertyGroup>
    <TargetFramework>net7.0</TargetFramework>
  </PropertyGroup>
  <ItemGroup>
    <PackageReference Include="Microsoft.Extensions.Hosting" />
  </ItemGroup>
</Project>
```

Next, we need to add the following lines to our `CreateHostBuilder`.

```csharp
public static IHostBuilder CreateHostBuilder(string[] args)
{
    return Host.CreateDefaultBuilder(args)
        .UseSystemd()
        .UseWindowsService()
        .ConfigureServices((hostContext, services) =>
        {
            services.AddHostedService<Worker>();
        });
}
```

## The Worker class

Lastly, we can create our background service worker class, which is executed asynchronously, has logging, and has configuration built in too.

```csharp
    public class Worker : BackgroundService
    {
        private readonly ILogger<Worker> _logger;
        private readonly IConfiguration configuration;

        public Worker(ILogger<Worker> logger, IConfiguration configuration)
        {
            _logger = logger;
            this.configuration = configuration;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                await Task.Delay(1000, stoppingToken);
            }
        }
    }
```
