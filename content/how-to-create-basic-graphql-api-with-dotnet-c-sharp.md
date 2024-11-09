---
title: "How To: Create a Basic GraphQL API with dotnet in C#"
date: 2024-11-09T19:10:09Z
draft: false
tags: ["how-to", "graphql", "c-sharp", "dotnet"]
author: ["darren horrocks"]
---

GraphQL is better than OData, and REST... So this guide will show you how to create a GraphQL API allows you to offer a flexible data querying interface where clients can request exactly the data they need. Here, we’ll create a simple GraphQL API in C# that returns data about music artists and their albums.

<!--more-->

### Prerequisites

To follow along, you need to make sure that you have:

- **.NET SDK** (version 5 or later)
- Familiarity with **ASP.NET Core**
- **GraphQL for .NET library**

You can download the .NET SDK from [the .NET website](https://dotnet.microsoft.com/download).

### Set Up Your Project

1. **Create a new ASP.NET Core Web API project**:
    ```bash
    dotnet new webapi -n GraphQLMusicApi
    cd GraphQLMusicApi
    ```

2. **Add the GraphQL.NET package**:
    ```bash
    dotnet add package GraphQL --version 4.6.1
    ```

3. **Add ASP.NET Core GraphQL integration**:
    ```bash
    dotnet add package GraphQL.Server.Transports.AspNetCore --version 5.0.0
    ```

### Define Your Data Models

For this example, we’ll create two simple models: `Artist` and `Album`.

```csharp
public class Artist
{
    public int Id { get; set; }
    public string Name { get; set; }
    public List<Album> Albums { get; set; }
}

public class Album
{
    public int Id { get; set; }
    public string Title { get; set; }
    public int Year { get; set; }
}
```

Next, we’ll create a data repository to act as our data source.

```csharp
public class MusicRepository
{
    private readonly List<Artist> _artists = new List<Artist>
    {
        new Artist { 
            Id = 1, 
            Name = "The Beatles", 
            Albums = new List<Album>
            {
                new Album { Id = 1, Title = "Abbey Road", Year = 1969 },
                new Album { Id = 2, Title = "Let It Be", Year = 1970 }
            }
        },
        new Artist { 
            Id = 2, 
            Name = "Pink Floyd", 
            Albums = new List<Album>
            {
                new Album { Id = 3, Title = "The Dark Side of the Moon", Year = 1973 },
                new Album { Id = 4, Title = "Wish You Were Here", Year = 1975 }
            }
        }
    };

    public IEnumerable<Artist> GetAllArtists() => _artists;
    public Artist GetArtistById(int id) => _artists.FirstOrDefault(a => a.Id == id);
}
```

### Define the GraphQL Schema

With GraphQL, we need to define types and queries for our models.

1. **Create the Album GraphQL Type**:

   ```csharp
   using GraphQL.Types;

   public class AlbumType : ObjectGraphType<Album>
   {
       public AlbumType()
       {
           Field(x => x.Id).Description("The ID of the album.");
           Field(x => x.Title).Description("The title of the album.");
           Field(x => x.Year).Description("The release year of the album.");
       }
   }
   ```

2. **Create the Artist GraphQL Type**:

   ```csharp
   public class ArtistType : ObjectGraphType<Artist>
   {
       public ArtistType()
       {
           Field(x => x.Id).Description("The ID of the artist.");
           Field(x => x.Name).Description("The name of the artist.");
           Field<ListGraphType<AlbumType>>("albums", "The albums by the artist");
       }
   }
   ```

3. **Define the Query Class**:

   This class defines the queries for retrieving artists and albums.

   ```csharp
   public class MusicQuery : ObjectGraphType
   {
       public MusicQuery(MusicRepository repository)
       {
           Field<ListGraphType<ArtistType>>(
               "artists",
               resolve: context => repository.GetAllArtists()
           );

           Field<ArtistType>(
               "artist",
               arguments: new QueryArguments(new QueryArgument<IntGraphType> { Name = "id" }),
               resolve: context =>
               {
                   var id = context.GetArgument<int>("id");
                   return repository.GetArtistById(id);
               }
           );
       }
   }
   ```

4. **Create the Schema**:

   ```csharp
   public class MusicSchema : Schema
   {
       public MusicSchema(IServiceProvider provider) : base(provider)
       {
           Query = provider.GetRequiredService<MusicQuery>();
       }
   }
   ```

### Set Up Dependency Injection and Middleware

To use these services, add them to the service collection and configure middleware in `Startup.cs`.

1. **Configure Services**:

   ```csharp
   public void ConfigureServices(IServiceCollection services)
   {
       services.AddSingleton<MusicRepository>();
       services.AddSingleton<AlbumType>();
       services.AddSingleton<ArtistType>();
       services.AddSingleton<MusicQuery>();
       services.AddSingleton<ISchema, MusicSchema>();

       services.AddGraphQL(options =>
       {
           options.EnableMetrics = false;
       }).AddSystemTextJson();
   }
   ```

2. **Configure Middleware**:

   In the `Configure` method, set up the GraphQL endpoint:

   ```csharp
   public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
   {
       app.UseRouting();

       app.UseEndpoints(endpoints =>
       {
           endpoints.MapGraphQL("/graphql");
       });
   }
   ```

### Test Your API

1. **Run your application**:
   ```bash
   dotnet run
   ```

2. **Navigate to** `http://localhost:5000/graphql`. You can test the API using a tool like GraphiQL or Postman.

3. **Example Queries**:

   - To get all artists and their albums:
     ```graphql
     query {
       artists {
         id
         name
         albums {
           title
           year
         }
       }
     }
     ```

   - To get a specific artist by ID:
     ```graphql
     query {
       artist(id: 1) {
         name
         albums {
           title
           year
         }
       }
     }
     ```

### Wrapping Up

With just a few steps, you’ve created a GraphQL API for music artists and albums. This basic API can be expanded with more complex types, queries, and mutations as needed, offering powerful data flexibility for your clients. Happy coding!
