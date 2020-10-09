---
title: "Writing Your Own Programming/Scripting Language in C#"
date: 2020-10-07T21:00:00+01:00
draft: true
tags: ["c#", "dotnet", "dotnetcore", "programming", "scripting"]
author: ["darren"]
---

A couple of years ago, I looked to replace a full fledged javascript engine in a project i was working on, with a much more basic engine, since all that was being used was the base math and logic operators.

So I started and it worked. Recently, I decided to make it slightly more powerful.

[Find the code here](https://github.com/bizzehdee/DScript)
<!--more-->

## The Idea

When picking the "language" back up, I decided I wanted to support:

- Comments (single and multiline)
- Variables
- Classes/Objects
- Methods
- Scope Levels
- Operators
- Basic exception handling (try/catch/finally/throw)

## Lexer

The lexer is a simple lexer that does standard character by character lexical analysis/tokenisation.

## Interpreter

