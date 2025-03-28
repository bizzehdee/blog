---
title: ".NET Aspire - Microsoft's Attempt at Infrastructure as Code"
date: 2025-03-28T10:21:43Z
draft: false
author: ["darren horrocks"]
tags: ["aspire", "IaC", "dotnet"]
---

.NET Aspire is a new set of tools, templates, and packages from Microsoft designed to make building cloud-native applications with .NET easier and more efficient. It helps developers create applications that are resilient, observable, and ready for production.
<!--more-->

## What is .NET Aspire?

Traditionally, developers wrote code while operations teams managed the infrastructure it ran on. This separation could lead to challenges in ensuring that applications and their environments worked well together. .NET Aspire aims to bridge this gap by allowing developers to define both their applications and the necessary infrastructure in a unified way.

## How Does .NET Aspire Work?

In a .NET Aspire project, you can define various components like databases, caches, and APIs, and specify how they connect. This is done in a central place called the "app host," which acts as an orchestrator for your application. Here's an example:

```csharp
var builder = DistributedApplication.CreateBuilder(args);

var postgres = builder.AddPostgres("postgres");
var catalogDb = postgres.AddDatabase("catalogdb");

var basketCache = builder.AddRedis("basketcache");

var productsApi = builder.AddProject<Projects.Aspire_Products_Api>("productsapi")
    .WithReference(catalogDb);

var basketApi = builder.AddProject<Projects.Aspire_Basket_Api>("basketapi")
    .WithReference(basketCache);

builder.AddProject<Projects.Aspire_Frontend>("frontend")
    .WithReference(basketApi)
    .WithReference(productsApi);
```

In this code, a PostgreSQL database and a Redis cache are set up. These are then linked to the appropriate backend APIs for products and baskets. Finally, the frontend application is connected to these backend services. This setup ensures that each part of the application knows how to communicate with the others without needing to know specific URLs or connection details.

## What Does This Mean for Infrastructure as Code (IaC)?

Infrastructure as Code (IaC) tools like ARM templates, Terraform, or Pulumi have traditionally been used to define and manage infrastructure separately from application code. With .NET Aspire, some of this infrastructure definition moves into the application code itself. For example, you can define role-based access controls (RBAC) directly within your application:

```csharp
var storage = builder.AddAzureStorage("mystorage")
    .WithRoleAssignment("StorageBlobDataOwner", "myapp");
```

This approach allows developers to manage integrations, roles, and boundaries directly within their applications. However, it's important to carefully manage security and coordinate between application-level and platform-level IaC to ensure a secure and efficient system.

## Where Does IaC Fit In?

While .NET Aspire enables developers to define much of their application's infrastructure, traditional IaC tools still play a crucial role in managing broader infrastructure aspects like networking, firewalls, and overall system isolation. IaC ensures that the system is securely set up and provides the necessary access points for applications to function correctly.

## Conclusion

.NET Aspire represents a shift towards integrating application development and infrastructure management. By allowing developers to define infrastructure needs within their application code, it provides greater control and streamlines the development process. However, traditional IaC tools remain essential for managing the broader infrastructure environment, ensuring security, and maintaining system integrity.
