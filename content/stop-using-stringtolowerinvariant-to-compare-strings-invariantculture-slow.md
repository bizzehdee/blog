---
title: "Stop Using string.ToLowerInvariant() to Compare Strings. InvariantCulture Comparisons are Slow"
date: 2024-03-07T11:29:49Z
draft: false
author: ["darren horrocks"]
tags: ["dotnet", "csharp", "programming", "strings", "performance"]
---

A lot of people use ```ToLower()``` or ```ToLowerInvariant()``` to normalise their strings before comparing them with ```==```, STOP IT.

This is very slow, and while that may not matter for 1 or 2 string comparasons, it mounts up in large projects.

While there is a very small use case for using Invariant Culture, unless you are absolutely certain that you need it, and why you need it, then you do not need it.

<!--more-->

[These tests in github](https://github.com/bizzehdee/StringEqualsSpeedTests) aim to show what we should be using instead.

Each test was ran 100,000,000 times, which is a realistic number of records that could be compared in a loop.

| Test                                    | Time in ms  |
| --------------------------------------- | ----------- |
| ToLowerInvariant                        | 2667 ms     |
| ToUpperInvariant                        | 2302 ms     |
| DOUBLE ToLowerInvariant                 | 3864 ms     |
| Equals (NoOptions) (as a control test)  | 426 ms      |
| Equals (InvariantCultureIgnoreCase)     | 14891 ms    |
| Equals (CurrentCultureIgnoreCase)       | 14605 ms    |
| Equals (OrdinalIgnoreCase)              | 1168 ms     |

As you can see, Equals with ```OrdinalIgnoreCase``` is an order of magnitude faster than ```InvariantCultureIgnoreCase```, and about twice as fast (half as slow) as ```ToLowerInvariant```. Stop using Invariant unless you absolutely understand your use case for it.

![Example](https://raw.githubusercontent.com/bizzehdee/StringEqualsSpeedTests/master/output.png)
