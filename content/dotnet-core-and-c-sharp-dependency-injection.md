---
title: "dotnet Core and C# Dependency Injection"
date: 2019-11-28T11:22:44Z
draft: true
tags: ["dotnet", "core", "di", "dependency injection", "c#"]
---

This is a short introduction into Dependency Injection for those who are new to dotnet core and C#, with an attempt to explain what it is, and how it works.
<!--more-->

## So, what is Dependency Injection?

DI is a programming method that makes each class independent of the other classes around it. Meaning that we don't rely on our dependencies working exactly how we expect, and only rely on the API being there to use.

## What's the point?

The two main advantages are:

* **Flexibility**: The implementation of each dependency can be switched for any other implementation, as only the interface is required by each class.
* **Testability**: Relying only on interfaces allows us to test individual classes on their own without relying on any of the dependencies, making testing simpler and more straight forward.

## How to use it in dotnet core?

Fortunately, dotnet core has a built in Dependency Injection engine (referred to as DI, or IoC or Inversion of Control), in fact, it is used by many of the internal dotnet core services and frameworks. The best thing, is that it all exists within `Microsoft.Extensions.DependencyInjection`, which can be added via nuget if you do not already have it in your project.

## How do we know what is and is not a service we should register?

It is quite simple, and there are a few "rules" to help you figure it out:

* **Lifespan within the scope**: Are we instantiating the service in the scope of the method?
* **Multiple versions**, Is there be more than one (possible) version of this service?
* **Testing**, really, you only want to test one specific method at a time. If you have code that does many other things, you should to move that to a dedicated service. This moved code would then become a dependency its self.
* **Output**, i.e accessing a network resource, doing an API call or interacting with I/O - then it should be placed in a separate service and be injected in as a dependency.

## Example

```csharp
public void CompletePurchase(double amount, string cardNumber, string address, string city, string name) 
{
  var paymentService = new PaymentService();
  var successfullyCharged = paymentService.Charge(int amount, cardNumber);

  if (successfullyCharged) 
  {
    var shippingService = new ShippingService();
    shippingService.Ship(address, city, name);
  }
}
```

The problems with the above code are:

* The first problem is that we directly instantiate `PaymentService` and `ShippingService`, so we risk triggering a HTTP call when trying to test
* We would have to include test code paths into `PaymentService` and `ShippingService`, meaning that all code paths are not fully tested
* 

