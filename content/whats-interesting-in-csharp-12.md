---
title: "New and Interesting Features in C# 12"
date: 2023-07-13T00:08:00+01:00
draft: false
author: ["darren horrocks"]
tags: ["dotnet", "csharp", "net8", "visualstudio"]
---

C# 12 introduces several features aimed at laying the foundation for future performance enhancements. These features include easy access to inline arrays, an experimental feature called interceptors, and enhancements to the ```nameof``` keyword.

<!--more-->

Inline arrays allow libraries to use them more conveniently without additional effort. They provide efficient and type-safe access to a contiguous sequence of primitives. The compiler generates different IL (Intermediate Language) code to access inline arrays, resulting in performance gains without requiring changes to your code.

Interceptors are an experimental feature intended for advanced scenarios, particularly for better ahead-of-time compilation (AOT). They allow specific method calls to be rerouted to different code. Interceptors are primarily used in conjunction with source generators. By enabling interceptors in your project file, you can benefit from code patterns such as optimized static code generation, direct call bypassing allocation and indirection, vectorization, dependency graph resolution, query translation, and compile-time serialization.

It's important to note that interceptors are experimental and should not be used in production. They may undergo changes or be removed in future versions of C# and .NET.

To access C# 12 features, you need to install the latest Visual Studio preview or the latest .NET SDK. Additionally, you'll need to set the language version of your project to "preview" in the project file. Interceptors require an additional flag in the project file to enable them.

Read more over on the [microsoft dev blogs](https://devblogs.microsoft.com/dotnet/new-csharp-12-preview-features/).
