---
title: "C# Design Patterns: A Practical Guide"
date: 2023-11-20T20:25:34Z
draft: false
author: ["darren horrocks"]
tags: ["dotnet", "csharp", "programming"]
---

Design patterns offer reusable solutions to common problems in software design, providing a framework for creating flexible and maintainable code. In C#, understanding and implementing design patterns can significantly enhance the structure and efficiency of your applications. This practical guide will explore key design patterns in C#, providing real-world examples to illustrate their application.

<!--more-->

## 1. Understanding Design Patterns
   - Design patterns are proven solutions to recurring design problems.
   - Three main categories: Creational, Structural, and Behavioral.

## 2. Creational Design Patterns
   ### a. Singleton Pattern
   - Ensures a class has only one instance and provides a global point to that instance.
   - **C# Implementation:**
     ```csharp
     public class Singleton
     {
         private static Singleton _instance;
         private Singleton() { }

         public static Singleton Instance
         {
             get
             {
                 if (_instance == null)
                 {
                     _instance = new Singleton();
                 }
                 return _instance;
             }
         }
     }
     ```

   ### b. Factory Method Pattern
   - Defines an interface for creating an object but lets subclasses alter the type of objects that will be created.
   - **C# Implementation:**
     ```csharp
     public interface IProduct
     {
         void Produce();
     }

     public class ConcreteProduct : IProduct
     {
         public void Produce() => Console.WriteLine("Producing Concrete Product");
     }

     public abstract class Creator
     {
         public abstract IProduct FactoryMethod();
     }

     public class ConcreteCreator : Creator
     {
         public override IProduct FactoryMethod() => new ConcreteProduct();
     }
     ```

   ### c. Abstract Factory Pattern
   - Provides an interface for creating families of related or dependent objects without specifying their concrete classes.
   - **C# Implementation:**
     ```csharp
     public interface IAbstractFactory
     {
         IProductA CreateProductA();
         IProductB CreateProductB();
     }

     public interface IProductA { }
     public interface IProductB { }

     public class ConcreteFactory : IAbstractFactory
     {
         public IProductA CreateProductA() => new ConcreteProductA();
         public IProductB CreateProductB() => new ConcreteProductB();
     }

     public class ConcreteProductA : IProductA { }
     public class ConcreteProductB : IProductB { }
     ```

## 3. Structural Design Patterns
   ### a. Adapter Pattern
   - Allows incompatible interfaces to work together.
   - **C# Implementation:**
     ```csharp
     public interface ITarget
     {
         void Request();
     }

     public class Adaptee
     {
         public void SpecificRequest() => Console.WriteLine("Specific Request");
     }

     public class Adapter : ITarget
     {
         private readonly Adaptee _adaptee;

         public Adapter(Adaptee adaptee) => _adaptee = adaptee;

         public void Request() => _adaptee.SpecificRequest();
     }
     ```

   ### b. Decorator Pattern
   - Attaches additional responsibilities to an object dynamically.
   - **C# Implementation:**
     ```csharp
     public interface IComponent
     {
         void Operation();
     }

     public class ConcreteComponent : IComponent
     {
         public void Operation() => Console.WriteLine("Concrete Component");
     }

     public class Decorator : IComponent
     {
         private readonly IComponent _component;

         public Decorator(IComponent component) => _component = component;

         public void Operation()
         {
             _component.Operation();
             Console.WriteLine(" + Decorator");
         }
     }
     ```

   ### c. Composite Pattern
   - Composes objects into tree structures to represent part-whole hierarchies.
   - **C# Implementation:**
     ```csharp
     public abstract class Component
     {
         public abstract void Operation();
     }

     public class Leaf : Component
     {
         public override void Operation() => Console.WriteLine("Leaf Operation");
     }

     public class Composite : Component
     {
         private readonly List<Component> _children = new List<Component>();

         public void Add(Component component) => _children.Add(component);

         public override void Operation()
         {
             Console.WriteLine("Composite Operation");
             foreach (var child in _children)
             {
                 child.Operation();
             }
         }
     }
     ```

## 4. Behavioral Design Patterns
   ### a. Observer Pattern
   - Defines a one-to-many dependency between objects so that when one object changes state, all its dependents are notified.
   - **C# Implementation:**
     ```csharp
     public interface IObserver
     {
         void Update(string message);
     }

     public class ConcreteObserver : IObserver
     {
         public void Update(string message) => Console.WriteLine($"Received update: {message}");
     }

     public class Subject
     {
         private readonly List<IObserver> _observers = new List<IObserver>();

         public void Attach(IObserver observer) => _observers.Add(observer);

         public void NotifyObservers(string message)
         {
             foreach (var observer in _observers)
             {
                 observer.Update(message);
             }
         }
     }
     ```

   ### b. Strategy Pattern
   - Defines a family of algorithms, encapsulates each one, and makes them interchangeable.
   - **C# Implementation:**
     ```csharp
     public interface IStrategy
     {
         void Execute();
     }

     public class ConcreteStrategyA : IStrategy
     {
         public void Execute() => Console.WriteLine("Executing Strategy A");
     }

     public class ConcreteStrategyB : IStrategy
     {
         public void Execute() => Console.WriteLine("Executing Strategy B");
     }

     public class Context
     {
         private IStrategy _strategy;

         public Context(IStrategy strategy) => _strategy = strategy;

         public void SetStrategy(IStrategy strategy) => _strategy = strategy;

         public void ExecuteStrategy() => _strategy.Execute();
     }
     ```

   ### c. Command Pattern
   - Encapsulates a request as an object, thereby allowing for parameterization of clients with different requests, queuing of requests, and logging of the requests.
   - **C# Implementation:**
     ```csharp
     public interface ICommand
     {
         void Execute();
     }

     public class ConcreteCommand : ICommand
     {
         private readonly Receiver _receiver;

         public ConcreteCommand(Receiver receiver) => _receiver = receiver;

         public void Execute() => _receiver.Action();
     }

     public class Receiver
     {
         public void Action() => Console.WriteLine("Receiver Action");
     }

     public class Invoker
     {
         private ICommand _command;

         public void SetCommand(ICommand command) => _command = command;

         public void ExecuteCommand() => _command.Execute();
     }
     ```

## Conclusion

This practical guide has introduced several fundamental design patterns in C#, providing both conceptual understanding and practical implementations. Incorporating these patterns into your projects can significantly improve code organization, maintainability, and flexibility. As you delve deeper into C# development, consider exploring more design patterns tailored to your specific application needs.
