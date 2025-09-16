---
title: "Why Event Driven Systems Are Not That Hard"
date: 2025-09-16T12:42:34+01:00
draft: false
tags: ["dotnet", "distributed", "event-driven", "programming"]
author: ["darren horrocks"]
---

Having recently read the article "[Why are Event-Driven Systems Hard?](https://newsletter.scalablethread.com/p/why-event-driven-systems-are-hard)", and having worked on several event-driven systems myself, I began to wonder why people so often frame these systems as inherently difficult. It’s true that event-driven and distributed systems **can** be hard to work with—especially if approached without the right mindset or tooling, but that doesn’t mean they **are** hard by default.

In fact, many of the “hard parts” that architects and developers worry about such as eventual consistency, debugging asynchronous flows and ensuring reliability, are well understood and largely solved with modern practices. With the dotnet ecosystem (or any other mature ecosystem), frameworks, and observability platforms, implementing event-driven systems has become far more approachable than it was even a few years ago. The gap between theory and practice has narrowed significantly, making these architectures not only manageable but often the most straightforward option for scaling, decoupling, and evolving complex applications.

<!--more-->

## **Publishing and Handling Events Isn’t Hard**

In .NET, you don’t need to reinvent the wheel. Frameworks like **MediatR**, **MassTransit**, and **NServiceBus** make event publishing and consumption straightforward.

**Example: Publishing a Domain Event with MediatR**

```csharp
// Define an event
public record OrderPlacedEvent(Guid OrderId, string CustomerEmail) : INotification;

// Publish event from domain service
public class OrderService
{
    private readonly IMediator _mediator;

    public OrderService(IMediator mediator)
    {
        _mediator = mediator;
    }

    public async Task PlaceOrder(Guid orderId, string customerEmail)
    {
        // business logic...
        await _mediator.Publish(new OrderPlacedEvent(orderId, customerEmail));
    }
}

// Event handler
public class SendEmailOnOrderPlaced : INotificationHandler<OrderPlacedEvent>
{
    public Task Handle(OrderPlacedEvent notification, CancellationToken cancellationToken)
    {
        Console.WriteLine($"Email sent to {notification.CustomerEmail} for Order {notification.OrderId}");
        return Task.CompletedTask;
    }
}
```

This looks almost like in-process events, but can later evolve into distributed event handling with minimal refactoring.

## **Distributed Messaging Made Easy with MassTransit**

If you need **cross-service messaging**, MassTransit (with RabbitMQ, Azure Service Bus, or Kafka) removes a lot of plumbing.

**Publishing an Event (Producer)**

```csharp
public class OrderController : ControllerBase
{
    private readonly IPublishEndpoint _publishEndpoint;

    public OrderController(IPublishEndpoint publishEndpoint)
    {
        _publishEndpoint = publishEndpoint;
    }

    [HttpPost("orders")]
    public async Task<IActionResult> CreateOrder(CreateOrderRequest request)
    {
        var orderId = Guid.NewGuid();
        await _publishEndpoint.Publish(new OrderPlacedEvent(orderId, request.CustomerEmail));
        return Ok(orderId);
    }
}

public record OrderPlacedEvent(Guid OrderId, string CustomerEmail);
```

**Consuming an Event (Consumer)**

```csharp
public class OrderPlacedConsumer : IConsumer<OrderPlacedEvent>
{
    public async Task Consume(ConsumeContext<OrderPlacedEvent> context)
    {
        var evt = context.Message;
        Console.WriteLine($"[Consumer] Sending welcome email to {evt.CustomerEmail}...");
        await Task.CompletedTask;
    }
}
```

MassTransit wires up consumers, retries, error queues, and observability out of the box. You don’t have to build these yourself.

## **Reliability Isn’t Hard: Use the Outbox Pattern**

A common complaint is *“What if the event is lost between DB and message bus?”*
The **Outbox pattern** ensures events are persisted with your data in the same transaction.

**EF Core Outbox Example**

```csharp
// Entity with outbox entries
public class OutboxMessage
{
    public Guid Id { get; set; }
    public string Type { get; set; }
    public string Payload { get; set; }
    public DateTime OccurredOn { get; set; }
    public bool Processed { get; set; }
}

// Save event inside same transaction
public async Task PlaceOrder(DbContext db, Guid orderId, string customerEmail)
{
    var order = new Order { Id = orderId, CustomerEmail = customerEmail };
    db.Orders.Add(order);

    var evt = new OrderPlacedEvent(orderId, customerEmail);
    var outbox = new OutboxMessage
    {
        Id = Guid.NewGuid(),
        Type = evt.GetType().Name,
        Payload = JsonSerializer.Serialize(evt),
        OccurredOn = DateTime.UtcNow
    };
    db.Add(outbox);

    await db.SaveChangesAsync();
}
```

A background service later reads **unprocessed OutboxMessages**, publishes them to the bus, and marks them processed. Libraries like [EntityFrameworkCore.Outbox](https://github.com/oskardudycz/EventSourcing.NetCore/tree/main/src/EventSourcing.Core) already implement this.

Reliability is solved with a proven pattern.

## **Observability Isn’t Hard with OpenTelemetry**

Tracing async events can feel tricky, but **OpenTelemetry for .NET** integrates with MassTransit, Kafka, RabbitMQ, and Azure Service Bus.

```csharp
builder.Services.AddOpenTelemetry()
    .WithTracing(tracerProviderBuilder =>
    {
        tracerProviderBuilder
            .AddAspNetCoreInstrumentation()
            .AddMassTransitInstrumentation()
            .AddHttpClientInstrumentation()
            .AddJaegerExporter(options =>
            {
                options.AgentHost = "localhost";
                options.AgentPort = 6831;
            });
    });
```

Every published and consumed event now gets correlated spans in Jaeger/Zipkin/Grafana Tempo.

## **Schema Contracts Aren’t Hard with AsyncAPI**

Instead of “wild west” event schemas, .NET teams can adopt **AsyncAPI** to describe event contracts, similar to Swagger for REST.

**Example OrderPlacedEvent AsyncAPI snippet:**

```yaml
components:
  messages:
    OrderPlacedEvent:
      contentType: application/json
      payload:
        type: object
        properties:
          orderId:
            type: string
            format: uuid
          customerEmail:
            type: string
```

Tools like **NSwag + AsyncAPI generator** can auto-generate C# contracts from this spec, removing guesswork.

## **Debugging Isn’t Hard with Event Stores**

If you want full **auditing and replayability**, libraries like [EventStoreDB](https://www.eventstore.com/) integrate smoothly with .NET.

```csharp
// Append to stream
await eventStore.AppendToStreamAsync(
    $"order-{orderId}",
    StreamState.Any,
    new[] { new EventData(Uuid.NewUuid(), "OrderPlaced", JsonSerializer.SerializeToUtf8Bytes(evt)) }
);

// Read back
var events = eventStore.ReadStreamAsync(Direction.Forwards, $"order-{orderId}", StreamPosition.Start);
await foreach (var resolvedEvent in events)
{
    Console.WriteLine($"Event: {resolvedEvent.Event.EventType}");
}
```

Debugging = replay from the event log, no mystery black box.

# Summary (with .NET Focus)

Event-driven systems **don’t have to be hard** when you leverage the right patterns and libraries:

* **MediatR**: simple in-process events, evolves to distributed.
* **MassTransit / NServiceBus**: cross-service pub/sub with retries, DLQs, observability baked in.
* **Outbox pattern**: guarantees no event loss.
* **OpenTelemetry**: distributed tracing across async boundaries.
* **AsyncAPI / NSwag**: enforce clear event contracts.
* **EventStoreDB**: full event sourcing + replay for debugging.

With these tools, most of the “hard” parts are already solved, so you can focus on domain modeling and business outcomes, not plumbing.
