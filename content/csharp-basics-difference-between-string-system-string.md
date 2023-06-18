---
title: "C# Basics: What is the difference between 'string' and 'System.String'"
date: 2022-04-27T11:25:13+01:00
draft: false
author: ["darren horrocks"]
series: "C-Sharp-Basics"
tags: ["dotnet", "csharp", "programming", "primitives", "types"]
reference: https://stackoverflow.com/questions/7074/what-is-the-difference-between-string-and-string-in-c
---

In C# [string](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/string) is an alias for [System.String](https://docs.microsoft.com/en-us/dotnet/api/system.string), So technically, there is no difference and they are exactly the same as comparing ```int``` and ```System.Int32```, they will compile to exactly the same code. but...
<!--more-->

There is a complete list of all aliases to primative types (not all are primitive actually):

```
object:  System.Object
string:  System.String
bool:    System.Boolean
byte:    System.Byte
sbyte:   System.SByte
short:   System.Int16
ushort:  System.UInt16
int:     System.Int32
uint:    System.UInt32
long:    System.Int64
ulong:   System.UInt64
float:   System.Single
double:  System.Double
decimal: System.Decimal
char:    System.Char
```

Besides ```string``` and ```object``` all of the aliases are value types. Although decimal is a value type it is not a primitive type in the CLR. System.IntPtr is the only primitive type which doesn't have an alias in C#.

These value type aliases are known as "simple types" in the C# spec, and literals can be used for constant values of every simple type.

With all that said, there is one time where you have to use the aliases: when explicitly specifying an enum's type:

```csharp
public enum BadClass : UInt32 {} // Invalid
public enum GoodClass : uint   {} // Valid
```

That's is simply down to the way the spec defines enums - the part after the colon has to be the integral-type, which is one of ```sbyte```, ```byte```, ```short```, ```ushort```, ```int```, ```uint```, ```long```, ```ulong```, ```char```, as opposed to a type as with variable declarations.

When it comes down to which you should use, it does not matter, any of the aliases or their underlaying types will be compiled down to the same MSIL or binary code.
