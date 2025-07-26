---
title: "Most Unit Tests Are a Waste of Time, but You Need to Write Them Anyway"
date: 2025-07-26T20:03:53+01:00
draft: false
tags: ["testing", "programming", "tests", "unit-testing", "unit-tests"]
author: ["darren horrocks"]
---

Yes, I'm saying it, **most unit tests feel like a waste of time**.

You write loads of them. They break when you refactor. They rarely catch real bugs. When you change implementations, you delete the tests. And when your build fails, it’s usually because a mocked method didn’t behave as expected — not because your code actually broke.

So why do we keep writing them?

Because while *most* unit tests **are** a waste of time, **some** aren’t — and knowing the difference is what separates a codebase held together by guesswork from one that’s confidently shippable.

<!--more-->

## Why Most Unit Tests Feel Pointless

In a typical C# MVC application, unit testing often devolves into **testing the mocks, not the code**. Consider:

### Example:

```csharp
var mockService = new Mock<IUserService>();
mockService.Setup(x => x.GetUser(1)).Returns(new User { Id = 1 });

var controller = new UserController(mockService.Object);
var result = controller.Get(1);
```

What are we really testing here?
Not the routing. Not the service logic. Just that a mock returns a hardcoded result we told it to. If this breaks, the app doesn’t necessarily break. If this passes, it doesn’t mean the app works.

Then there are **tests for trivial logic**:

```csharp
[Test]
public void Add_ShouldReturnSum()
{
    var math = new MathHelper();
    var result = math.Add(2, 2);
    Assert.AreEqual(4, result);
}
```

Congratulations, you proved addition works.
Now imagine 300 of these tests — offering zero protection against real bugs.

So yes, **most of these are a waste of your time**.

## But Here's Why You Still Need Them

Despite all that — you need to write tests anyway.

Not *because* they guarantee zero bugs (they don’t). But because:

### Tests Define Behavior

Well-written unit tests act as **executable documentation**. They describe what the system is supposed to do, especially when future devs (or future you) forget the intent.

### Tests Enable Refactoring

You can’t safely refactor without some safety net. If you’re pulling apart a C# service or controller, tests that cover logic (not mocks) help you know what broke *immediately*.

### Tests Catch Edge Cases You’ll Forget

You might test the happy path manually. But do you check null inputs every time? Timezone logic? Unauthorised users? Unit tests *can* force you to handle those cases.

## What to Write Instead of Meaningless Tests

Since we’ve established that **not all tests are worth writing**, here’s what *is*:

### 1. **Test Real Business Logic**

Skip trivial logic. Instead, focus on **functions that make decisions**, mutate data, or contain rules.

```csharp
[Test]
public void PromoteUser_ShouldSetRoleToAdmin()
{
    var user = new User("basic");
    var service = new UserService();

    service.Promote(user);

    Assert.AreEqual("Admin", user.Role);
}
```

This is logic that could break. This test is worth writing.

### 2. **Use In-Memory Dependencies Instead of Mocks**

Whenever possible, avoid mocking and use real implementations or in-memory versions.

```csharp
var options = new DbContextOptionsBuilder<AppDbContext>()
    .UseInMemoryDatabase("TestDb")
    .Options;

using var context = new AppDbContext(options);
context.Users.Add(new User { Id = 1, Name = "Alice" });
context.SaveChanges();

var service = new UserService(context);
var user = service.GetUser(1);

Assert.AreEqual("Alice", user.Name);
```

This approach:

* Covers real database logic (e.g., query filters, relationships)
* Doesn’t break when you rename a method
* Actually catches bugs

### 3. **Favor Integration Tests for Controllers**

In C# MVC apps, controller unit tests with mocked services rarely give you confidence. Instead, use **integration tests** that spin up the full pipeline:

```csharp
[Test]
public async Task GetUser_ReturnsExpectedUser()
{
    var client = _factory.CreateClient();
    var response = await client.GetAsync("/api/user/1");

    response.EnsureSuccessStatusCode();
    var body = await response.Content.ReadAsStringAsync();

    Assert.IsTrue(body.Contains("Alice"));
}
```

This tells you:

* Routing works
* The controller is wired correctly
* The real service/database returned something valid

## So What’s the Right Balance?

Here's a rule of thumb I’ve come to rely on:

> **If a test would still pass after you’ve broken the app, delete it.**

The tests worth keeping:

* Validate decisions or calculations
* Catch regressions during refactors
* Fail only when something meaningful breaks

## Final Thoughts: Write Less, Test Smarter

You don’t need 100% test coverage. You need **meaningful coverage**.

So yes — **most unit tests are a waste of time** when they’re written to check boxes or appease CI gates.
But tests that clarify logic, guard complex behavior, and give you confidence to ship? Those are worth every second.

**Write tests like your future self depends on them — because they do.**
