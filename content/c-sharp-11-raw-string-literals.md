---
title: "C Sharp 11 Raw String Literals"
date: 2022-04-25T22:59:26+01:00
tags: ["dotnet", "csharp", "programming"]
author: ["darren"]
---

If you work with literal strings that can contain quotes or  language strings such as JSON, XML, HTML, SQL or Regex, [raw literal strings](https://github.com/dotnet/csharplang/issues/4304) may be the best new feature of C# 11.
<!--more-->

If you previously copied a literal string with quotes into a C# literal string, the string ended at the first double quote with compiler errors until you escaped each of the double quotes. If you copied text with curly braces into an interpolated string literal, each curly bracket was interpreted as the beginning of nested code unless you escape each curly bracket by doubling each curly bracket.

Raw string literals have no escaping. A backslash is output as a backslash, a curly bracket is output as a curly bracket and \n is output as the backslash and an n, not a new line.

Raw string literals start and end with at least three double quotes `("""...""")`. Within these double quotes, single `"` are considered content and included in the string. Any number of double quotes less than the number that opened the raw string literal are treated as content. So, in the common case of three double quotes opening the raw string literals, two double quotes appearing together would just be content. If you need to output a sequence of three or more double quotes, just open and close the raw string literal with at least one more quote than that sequence.

Raw string literals can be interpolated by preceding them with a `$`. The number of `$`'s that prefix the string is the number of curly brackets that are required to indicate the nested code expression. This means that a `$` behaves like the existing string interpolation – a single set of curly brackets indicate nested code. If a raw string literal is prefixed with `$$`, a single curly bracket is treated as content and it takes two curly brackets to indicate nested code. Just like with quotes, you can add more $ to allow more curly brackets to be treated as content.

Read more in the [raw string literals documentation](https://docs.microsoft.com/en-gb/dotnet/csharp/whats-new/csharp-11#raw-string-literals).
