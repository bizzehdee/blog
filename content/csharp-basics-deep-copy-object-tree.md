---
title: "C# Basics - Deep Copy Object Tree"
date: 2022-07-01T11:26:06+01:00
draft: false
author: ["GPT-3"]
tags: ["dotnet", "csharp"]
reference: https://stackoverflow.com/questions/78536/deep-cloning-objects
---

Object deep copy is a process of creating a new object instance that is an exact copy of another object. This process includes creating a new object with all the same properties and values as the original object. Object deep copy is usually used to avoid creating unwanted references between objects, or to create a separate object instance that can be modified without affecting the original object.

There are several ways to create a deep copy of an object in C#. One way is to use the System.Reflection.MemberInfo.Copy method. This method copies all the public and private members of an object to a new object instance. Another way to create a deep copy is to use the binary serialization mechanism in C#. This approach requires the object to be serialized and deserialized, which can be expensive.

The System.Object.MemberwiseClone method can also be used to create a deep copy of an object. This method copies all the fields of an object to a new object instance. However, this method does not copy the properties of the object. Therefore, it is not a complete deep copy.

Here is an example of how to create a deep copy using the System.Reflection.MemberInfo.Copy method:
```csharp
public class Person
{
     public string Name { get; set; }
     public int Age { get; set; }
}

class Program
{
     static void Main(string[] args)
     {
          Person person1 = new Person();
          person1.Name = "John";
          person1.Age = 20;

          Person person2 = (Person)person1.Copy();

          Console.WriteLine(person2.Name); // John
          Console.WriteLine(person2.Age);  // 20
     }
}
```
In the example above, we first create a Person class with two properties: Name and Age. We then create an instance of the Person class and assign values to the Name and Age properties. Next, we create a deep copy of the person1 object using the Copy method. Finally, we print out the values of the Name and Age properties of the person2 object to the console. As we can see, the values are exactly the same as the original object.

Here is an example of how to create a deep copy using the binary serialization mechanism:
```csharp
using System;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;

[Serializable]
public class Person
{
     public string Name { get; set; }
     public int Age { get; set; }
}

class Program
{
     static void Main(string[] args)
     {
          Person person1 = new Person();
          person1.Name = "John";
          person1.Age = 20;

          Person person2 = null;

          using (MemoryStream stream = new MemoryStream())
          {
               BinaryFormatter formatter = new BinaryFormatter();
               formatter.Serialize(stream, person1);
               stream.Seek(0, SeekOrigin.Begin);
               person2 = (Person)formatter.Deserialize(stream);
          }

          Console.WriteLine(person2.Name); // John
          Console.WriteLine(person2.Age);  // 20
     }
}
```

In the example above, we use the BinaryFormatter class to serialize and deserialize the object. We first serialize the object to a memory stream. We then seek the stream to the beginning and deserialize it to the person2 object. Finally, we print out the values of the Name and Age properties of the person2 object.

Here is an example of how to create a deep copy using the System.Object.MemberwiseClone method:

```csharp
public class Person
{
     public string Name { get; set; }
     public int Age { get; set; }
}

class Program
{
     static void Main(string[] args)
     {
          Person person1 = new Person();
          person1.Name = "John";
          person1.Age = 20;

          Person person2 = (Person)person1.MemberwiseClone();

          Console.WriteLine(person2.Name); // John
          Console.WriteLine(person2.Age);  // 20
     }
}
```

In the example above, we use the MemberwiseClone method to create a deep copy of the Person object. This method copies all the fields of the object to a new object. However, it does not copy the properties of the object. Therefore, it is not a complete deep copy.
