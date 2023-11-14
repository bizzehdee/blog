---
title: "Exploring What's New in C# 12"
date: 2023-11-14T21:15:20Z
draft: false
author: ["darren horrocks"]
tags: ["dotnet", "csharp", "net8", "visualstudio", "dotnet"]
---

C# 12 has arrived, bringing a plethora of features aimed at enhancing developer productivity, simplifying code, and boosting application performance. Let's delve into the key improvements introduced in this latest version.

<!--more-->

## Getting Started with C# 12

To leverage the new features of C# 12, developers are encouraged to download .NET 8, the latest Visual Studio, or Visual Studio Code's C# Dev Kit. Existing projects can be upgraded by indicating the desired language version, accomplished by changing the `TargetFramework` to `.NET 8.0` in the project file.

```xml
<Project Sdk="Microsoft.NET.Sdk">
    <PropertyGroup>
        <TargetFramework>net8.0</TargetFramework>
        <!-- ... -->
    </PropertyGroup>
</Project>
```

## Simplifying Code for Better Productivity

C# 12 focuses on streamlining code, making it more expressive and efficient without sacrificing performance. The improvements can be explored in detail in the "What’s new in C# 12" article on MS Learn, which also provides links to updated documentation.

### Collection Expressions

One notable enhancement is the introduction of collection expressions, offering a unified syntax for creating collections. Before C# 12, different scenarios required varied syntax for initializing collections. Now, developers can use a single syntax for arrays, lists, spans, and more:

```csharp
int[] x1 = [1, 2, 3, 4];
int[] x2 = [];
WriteByteArray([1, 2, 3]);
List<int> x4 = [1, 2, 3, 4];
Span<DateTime> dates = [GetDate(0), GetDate(1)];
WriteByteSpan([1, 2, 3]);
```

The compiler generates optimized code, often improving performance and avoiding unnecessary data copying. Additionally, a new spread operator allows the inclusion of elements from multiple collections within a single expression.

### Primary Constructors on Any Class or Struct

C# 12 extends primary constructors to work on all classes and structs, not just records. This feature enables the definition of constructor parameters directly in the class declaration, simplifying code and reducing boilerplate:

```csharp
public class BankAccount(string accountID, string owner)
{
    public string AccountID { get; } = accountID;
    public string Owner { get; } = owner;

    public override string ToString() => $"Account ID: {AccountID}, Owner: {Owner}";
}
```

Primary constructors serve various purposes, such as providing arguments to a base constructor, initializing fields or properties, and reducing boilerplate in dependency injection.

### Alias Any Type

C# 12 introduces the ability to alias any type using `using` alias directives. This allows developers to remove complex type signatures from their code, improving readability:

```csharp
using intArray = int[]; // Array types.
using Point = (int x, int y);  // Tuple type
using unsafe ArrayPtr = int*;  // Pointer type (requires "unsafe")
```

These type aliases can be used at the top of a file and in global `using` statements.

### Default Lambda Parameters

Lambda expressions in C# 12 support default parameters, allowing developers to skip passing values and add parameters to existing lambda expressions without breaking calling code:

```csharp
var IncrementBy = (int source, int increment = 1) => source + increment;

Console.WriteLine(IncrementBy(5));    // 6
Console.WriteLine(IncrementBy(5, 2)); // 7
```

This feature simplifies accessing lambda expressions and aligns with the simplicity offered by default parameters in regular methods.

## Making Code Faster with Raw Memory Improvements

C# 12 continues to enhance raw memory capabilities, contributing to improved application performance. Two key additions are `ref readonly parameters` and `inline arrays`.

### Ref Readonly Parameters

The introduction of `ref readonly parameters` provides a final combination of passing parameters by reference or by value. These parameters must be variables, enhancing memory optimization:

```csharp
void ProcessData(ref readonly int data)
{
    // Access data without modification
}
```

### Inline Arrays

Inline arrays offer a safe way to work with memory buffers, providing a struct-based, fixed-length array type. Developers can manipulate blocks of memory without enabling unsafe code, thereby improving application performance:

```csharp
struct InlineArray<T>
{
    private T[] data;

    // Implementation details...
}
```

## Experimental Features: Pushing the Boundaries

C# 12 introduces experimental features, including the `experimental attribute` and `interceptors`, aimed at gathering feedback and exploring new possibilities.

### Experimental Attribute

The `experimental attribute` is applied to types, members, and assemblies, signaling that the feature is under exploration and not yet committed to the implementation. This allows developers to suppress errors for individual experimental features and explore them using explicit compiler options or pragmas.

### Interceptors

Interceptors, available in preview mode with C# 12, enable the redirection of method calls. This experimental feature allows an optimized version of a method, generated for specific parameters, to replace a less efficient generalized method.

Developers interested in these experimental features are encouraged to mark their code accordingly, using the `ExperimentalAttribute` to indicate the experimental nature of their libraries.

## Conclusion

C# 12 introduces a wealth of features aimed at improving developer productivity, simplifying code, and enhancing application performance. From unified collection expressions to primary constructors on any class or struct, type aliases, default lambda parameters, and raw memory improvements, developers have an array of tools to streamline their code and build faster, more efficient applications. Additionally, the inclusion of experimental features demonstrates a commitment to exploring new possibilities and gathering valuable feedback from the developer community. As developers embrace C# 12, they can look forward to a more expressive and performant coding experience.