---
title: "Don't Buffer, Stream! How IAsyncEnumerable<T> Solves API Performance Issues"
date: 2025-08-18T11:34:34+01:00
draft: false
tags: ["dotnet", "performance", "optimisation"]
author: ["darren horrocks"]
---

Building APIs that handle large datasets can be a challenge. A common approach is to collect all the data into a list, convert it to JSON, and then send it all at once. But what happens when that dataset is massive? Your API might freeze up while it's building the response, and you could end up with a huge memory footprint. Fortunately, ASP.NET Core provides a great solution for this problem: **`IAsyncEnumerable<T>`**.

<!--more-->

### What is `IAsyncEnumerable<T>`?

Introduced in C# 8.0, `IAsyncEnumerable<T>` allows you to iterate through data asynchronously. This is perfect for streaming scenarios where you need to process or return data in chunks, rather than all at once. When you use it in an ASP.NET Core API endpoint, the framework will serialise and send data to the client as it becomes available. This is different from the traditional approach, where the entire collection must be ready before the response can be sent.

-----

### Why Use `IAsyncEnumerable<T>`?

There are two main benefits to using `IAsyncEnumerable<T>` for your API endpoints:

**1. Improved Performance:** You no longer have to wait for the entire dataset to be built in memory. As soon as the first item is ready, it can be sent to the client. This can significantly reduce the time to first byte and make your API feel more responsive, especially for large queries.

**2. Reduced Memory Usage:** Instead of holding the entire collection in memory, your application only needs to hold a small number of items at a time. This is a game-changer for handling large datasets, as it can prevent your application from consuming excessive memory and potentially crashing.

-----

### How to Implement It

Implementing `IAsyncEnumerable<T>` in an ASP.NET Core API is straightforward. Here’s a simple example of a controller method that streams a large number of items.

```csharp
[ApiController]
[Route("[controller]")]
public class ProductsController : ControllerBase
{
    // Simulates fetching a large number of products from a database
    private async IAsyncEnumerable<Product> GetProductsFromDatabase()
    {
        for (int i = 1; i <= 10000; i++)
        {
            await Task.Delay(50); // Simulate an async operation like a database call
            yield return new Product { Id = i, Name = $"Product {i}" };
        }
    }

    [HttpGet("stream")]
    public IAsyncEnumerable<Product> GetStreamedProducts()
    {
        return GetProductsFromDatabase();
    }
}

public class Product
{
    public int Id { get; set; }
    public string Name { get; set; }
}
```

In this example, the `GetProductsFromDatabase` method uses the **`yield return`** keyword to return items one by one. The `IAsyncEnumerable<Product>` return type tells the ASP.NET Core runtime to stream the data as it’s being generated.

-----

### Important Considerations

While `IAsyncEnumerable<T>` is a powerful tool, it's not a silver bullet. Keep these things in mind:

  * **Client Compatibility:** The client calling the API must be able to handle a streamed response. Most modern web clients and frameworks support this out of the box, but older or custom clients might have issues.
  * **Error Handling:** If an exception occurs partway through streaming, the client will receive an incomplete response. You need to handle errors gracefully and ensure the client can deal with a connection that might be abruptly closed.
  * **HTTP Protocol:** Under the hood, this works by leveraging the **Transfer-Encoding: chunked** header in HTTP. This is standard for HTTP/1.1 and later, but it's good to be aware of how the data is being sent.

-----

### Conclusion

For backend developers working with large datasets, `IAsyncEnumerable<T>` is a fantastic tool to have in your arsenal. It provides a simple and effective way to build more responsive and memory-efficient APIs. By streaming data instead of buffering it all in memory, you can significantly improve the user experience and the overall health of your application.