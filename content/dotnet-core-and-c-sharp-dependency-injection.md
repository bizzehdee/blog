---
title: "dotnet Core and C# Dependency Injection"
date: 2020-04-24T11:00:00Z
draft: false
tags: ["dotnet", "core", "di", "dependency injection", "c#", "ioc"]
author: ["darren"]
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
* We would have to include test code for `PaymentService` and `ShippingService`, or all code paths would not be fully tested
* We do not control this code due to the external code paths

What we should be doing is injecting the services via the class constructor, allowing us to swap out the implementations at will, with new implementations or with mock implementations.

```csharp
public class Checkout
{
  private IPaymentService _paymentService;
  private IShippingService _shippingService;

  public Checkout(IPaymentService paymentService, IShippingService shippingService) 
  {
    _paymentService = paymentService;
    _shippingService = shippingService;
  }

  public void CompletePurchase(double amount, string cardNumber, string address, string city, string name) 
  {
    var successfullyCharged = _paymentService.Charge(int amount, cardNumber);

    if (successfullyCharged) 
    {
      _shippingService.Ship(address, city, name);
    }
  }
}
```

This code now:

* Is only concerned about one thing, converting a charge into a shipment (where the actual charge, and shipping are performed by another service)
* We control the entirity of this code
* We can swap out different implementations of `IPaymentService` and `IShippingService` allowing us to create mock implementations so that we can test just `CompletePurchase` in isolation.

## Enter dotnet core

The built-in container is represented by an `IServiceProvider` implementation that supports constructor injection by default. The classes managed by the built-in IoC container are called services.

ASP.NET Core allows us to register our application services with IoC container, in the `ConfigureServices` method of the `Startup` class. The `ConfigureServices` method includes a parameter of the `IServiceCollection` interface which is used to register application services

```csharp
public class Startup
{
    public void ConfigureServices(IServiceCollection services)
    {
        services.Add(new ServiceDescriptor(typeof(IPaymentService), new PaymentService()));      
        services.Add(new ServiceDescriptor(typeof(IShippingService), new ShippingService()));        
    }

}
```

So IoC and DI in ASP.NET Core and dotnet core in general is very easy, and more or less built in.