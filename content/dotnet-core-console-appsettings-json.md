---
title: "Adding appsettings.json options to a dotnet core console application"
date: 2019-11-17T10:08:04Z
draft: false
tags: ["dotnet", "core", "options", "appsettings"]
---

Something that annoyingly does not come as standard in the dotnet core console application template, and, it is not documented anywhere with Microsoft is: appsettings.json.
This comes as standard with ASP.NET Core applications, but no other applications, and the thing is, it is very simple to add to any dotnet core application.

The first thing you will need to do is add the following nuget packages (at least) to your application:

* Microsoft.Extensions.Configuration
* Microsoft.Extensions.Configuration.FileExtensions
* Microsoft.Extensions.Configuration.Json

Once you have those packages installed, you can then add a new json file to the route of the project named "appsettings.json". When you have added the new json file, right click on it in the solution explorer, click properties, and in the properties panel, change the "copy to output directory" option to "copy if newer".

Once you have the basics done, we can move on to the code:

Your Program.cs file should now look something like this:

```cs
static void Main(string[] args)
{
    var config = new ConfigurationBuilder()
        .SetBasePath(Directory.GetCurrentDirectory())
        .AddJsonFile(
            "appsettings.json", 
            optional: true, 
            reloadOnChange: true
        )
        .Build();
}
```

The "optional: true" makes the appsettings.json file completely optional, if the file does not exist, the Build() will not throw an exception, and the "reloadOnChange: true" option will cause the config to be updated automatically when the json file is changed.

It is as simple as that, as I said before, I don't know why this is not part of the default template.
