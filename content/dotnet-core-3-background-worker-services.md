---
title: "Creating Windows and Linux background services in dotnet core 3.0/3.1"
date: 2020-04-30T19:00:00+01:00
draft: false
tags: ["dotnet", "core", "dotnetcore", "worker", "service", "background", "windows", "linux", "systemd"]
author: ["darren"]
---

In dotnet core 3.0, a new type of template was introduced, "Worker Service", which is a very easy way of creating Windows Services and Linux Daemons.
<!--more-->

## The Basics


## The Startup Class

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

We need to add 2 nuget packages and 2 lines to this

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

