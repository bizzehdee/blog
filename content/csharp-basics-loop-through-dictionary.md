---
title: "C# Basics: Loop Through a Dictionary"
date: 2022-04-27T11:25:28+01:00
draft: false
author: ["darren horrocks"]
tags: ["dotnet", "csharp", "programming", "dictionary", "loops"]
series: "C-Sharp-Basics"
reference: https://stackoverflow.com/questions/141088/how-to-iterate-over-a-dictionary
---

Dictionaries are essential data structures in C# that allow you to store key-value pairs. Looping through dictionaries enables you to iterate over each key-value pair and perform operations on them. In this article, we will explore different methods of looping through dictionaries in C# and discuss their applications.

<!--more-->

## Method 1: Using foreach Loop

The simplest and most common way to iterate through a dictionary is by using a foreach loop. The foreach loop automatically enumerates the key-value pairs of the dictionary. Here's an example

```cs
Dictionary<string, int> dictionary = new Dictionary<string, int>()
{
    { "Apple", 5 },
    { "Banana", 3 },
    { "Orange", 8 }
};

foreach (KeyValuePair<string, int> kvp in dictionary)
{
    string key = kvp.Key;
    int value = kvp.Value;
    
    // Perform operations with key-value pairs
    Console.WriteLine("Key: " + key + ", Value: " + value);
}
```

In this example, we have a dictionary containing fruit names as keys and their respective quantities as values. The foreach loop iterates through each key-value pair, allowing you to access the key and value individually for further processing.

## Method 2: Using Keys or Values Collection

If you only need to access either the keys or values of a dictionary, you can use the Keys or Values property to obtain a collection and loop through it. Here's an example:

```cs
Dictionary<string, int> dictionary = new Dictionary<string, int>()
{
    { "Apple", 5 },
    { "Banana", 3 },
    { "Orange", 8 }
};

foreach (string key in dictionary.Keys)
{
    // Accessing keys only
    Console.WriteLine("Key: " + key);
}

foreach (int value in dictionary.Values)
{
    // Accessing values only
    Console.WriteLine("Value: " + value);
}
```

In this example, we loop through the Keys collection to access and print each key individually. Similarly, we loop through the Values collection to access and print each value separately.

## Method 3: Using LINQ

LINQ (Language-Integrated Query) provides a powerful and concise way to query and manipulate data in C#. You can use LINQ to loop through dictionaries and apply various operations. Here's an example:

```cs
Dictionary<string, int> dictionary = new Dictionary<string, int>()
{
    { "Apple", 5 },
    { "Banana", 3 },
    { "Orange", 8 }
};

var sortedDictionary = dictionary.OrderBy(x => x.Key);

foreach (var kvp in sortedDictionary)
{
    string key = kvp.Key;
    int value = kvp.Value;
    
    // Perform operations with key-value pairs
    Console.WriteLine("Key: " + key + ", Value: " + value);
}
```

In this example, we use LINQ's OrderBy() method to sort the dictionary by keys in ascending order. Then, we loop through the sorted dictionary and access each key-value pair for further processing.

Looping through dictionaries in C# allows you to access and manipulate key-value pairs efficiently. The foreach loop is the most common method, providing direct access to both the keys and values. Alternatively, you can loop through the Keys or Values collection if you only need one of them. Additionally, LINQ provides a powerful way to query and manipulate dictionaries. With these methods, you can effectively iterate through dictionaries and perform operations on their contents in your C# applications.
