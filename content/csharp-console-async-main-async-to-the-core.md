---
title: "C# Console Async Main - Async Entry Point for Console Apps"
date: 2020-10-14T09:00:00+01:00
draft: false
tags: ["dotnet", "console", "csharp", "async"]
author: ["darren"]
---

As of C# 7.1, it is possible with console apps, to have async all the way to the entry point. The previous constraints of the entry point have been the same all the way up to this point, and similar to the entry point in C/C++ apps. The C# entry point method must be ```static```, the name of the method must be ```Main```, the return type must be either void or int and finally, the method can accept zero arguments, or exactly one argument of ```string[]```, which contains the command arguments.

<!--more-->

Given those limitations, the 4 possible entry points before C# 7.1 are:

```csharp
public static void Main();
public static int Main();
public static void Main(string[] args);
public static int Main(string[] args);
```

If we wanted to mimic async all the way to the core, we would have to do something like this:

```csharp
public static int Main(string[] args)
{
    return MainAsync(args).GetAwaiter().GetResult();
}

public static async Task<int> MainAsync(string[] args)
{
    //do async main
}
```

While this works, it looks dirty, and is an extra step we shouldnt need to be taking.

## C# 7.1

Now that we have C# 7.1, we get these new possible entry points for a console app.

```csharp
public static Task Main();
public static Task<int> Main();
public static Task Main(string[] args);
public static Task<int> Main(string[] args);
```

With C# 7.1, this makes async Main much easier, and much simpler and much better, and allows us to write apps that are console based that are async all the way down to the entry point, making for much more scope to create console apps without deadlocks, and without waiting for tasks that are CPU bound.
