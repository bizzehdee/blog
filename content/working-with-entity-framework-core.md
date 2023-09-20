---
title: "Working with Entity Framework Core in C#"
date: 2023-09-21T09:00:46+01:00
draft: false
author: ["darren horrocks"]
tags: ["dotnet", "core", "entity-framework", "entity-framework-core", "efcore"]
---

Entity Framework Core (EF Core) is a powerful and lightweight Object-Relational Mapping (ORM) framework for .NET applications. It simplifies database operations by allowing developers to work with .NET objects rather than writing raw SQL queries. In this tutorial, we'll explore the fundamentals of using Entity Framework Core in C#.

<!--more-->

## Getting Started

### Installing Entity Framework Core

Before you can start using EF Core, you need to install the necessary packages. In your project, open the NuGet Package Manager and install the ```Microsoft.EntityFrameworkCore``` and ```Microsoft.EntityFrameworkCore.SqlServer``` packages.

```bash
dotnet add package Microsoft.EntityFrameworkCore
dotnet add package Microsoft.EntityFrameworkCore.SqlServer
```

## Creating a DbContext

The ```DbContext``` is the heart of EF Core. It represents a session with the database and allows you to perform operations like querying, inserting, updating, and deleting entities.

```csharp
public class AppDbContext : DbContext
{
    public DbSet<User> Users { get; set; }
    // Add other DbSet properties for your entities here

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseSqlServer("YourConnectionString");
    }
}
```

Replace ```User``` with your own entity and provide your database connection string.

## Defining Entities

Entities are C# classes that represent tables in your database. Each property in the class corresponds to a column in the table.

```csharp
public class User
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Email { get; set; }
}
```

## Performing CRUD Operations

### Creating Records

```csharp
using (var context = new AppDbContext())
{
    var newUser = new User { Name = "John Doe", Email = "john@example.com" };
    context.Users.Add(newUser);
    context.SaveChanges();
}
```

### Reading Records

```csharp
using (var context = new AppDbContext())
{
    var users = context.Users.ToList();
    foreach (var user in users)
    {
        Console.WriteLine($"{user.Id}: {user.Name} - {user.Email}");
    }
}
```

### Updating Records

```csharp
using (var context = new AppDbContext())
{
    var user = context.Users.FirstOrDefault(u => u.Id == 1);
    if (user != null)
    {
        user.Email = "john.doe@newdomain.com";
        context.SaveChanges();
    }
}
```

### Deleting Records

```csharp
using (var context = new AppDbContext())
{
    var user = context.Users.FirstOrDefault(u => u.Id == 1);
    if (user != null)
    {
        context.Users.Remove(user);
        context.SaveChanges();
    }
}
```

## Querying with LINQ

EF Core allows you to use LINQ (Language Integrated Query) to write expressive and powerful queries.

```csharp
using (var context = new AppDbContext())
{
    var users = context.Users
        .Where(u => u.Name.Contains("John"))
        .OrderBy(u => u.Name)
        .ToList();
}
```

## Conclusion

Entity Framework Core provides a seamless way to interact with databases in C# applications. With its powerful features and simplicity, it has become a popular choice for .NET developers. By following this tutorial, you've gained a solid foundation for working with EF Core, enabling you to build robust and efficient data-driven applications.
