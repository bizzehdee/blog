---
title: "IMAP4 Client Protocol Library for C# and .NET"
date: 2021-01-13T18:25:21Z
draft: false
tags: ["dotnet", "imap", "csharp", "library", "email", "imap4"]
author: ["darren"]
---

 [System.Net.Imap4](https://github.com/bizzehdee/System.Net.Imap4) is an IMAP4 client library for .NET written in C# with support for parsing multipart, attachments, html and plain parts.
<!--more-->
It includes:

- [x] Plain and Encrypted (SSL/TLS) Connections
- [x] Fetching server capabilities
- [x] Authentication (Plain only)
- [x] Fetching folder lists/Folder selection
- [x] Fetching Email Counts
- [x] Fetching RAW email
- [x] Fetching parsed email
- [x] Deleting emails
- [x] Authentication (Plain only)
- [x] Waiting for emails (push emails)
- [x] Setting/Getting flags
- [x] Multipart emails
- [x] HTML emails
- [x] Attachments

Released under the BSD-3-Clause licence, and is also available for use as an easy to use [nuget package](https://www.nuget.org/packages/System.Net.Imap4/).

**Connect to GMail**
```csharp
static IMapClient ConnectToClient()
{
    
}
```

**Get email**
```csharp
static EmailMessage GetEmail(int id, IMapClient client)
{
    
}
```

**Delete email**
```csharp
static EmailMessage DeleteEmail(int id, IMapClient client)
{
    
}
```

**Get Attachment from email**
```csharp
static void GetAttachments(EmailMessage msg)
{
    
}
```
