---
title: "Microservices Introduction"
date: 2019-11-12T20:42:47Z
draft: false
series: "Microservices"
tags: ["microservices", "azure", "servicebus", "dotnet", "dotnetcore", "service"]
author: ["darren"]
---

Everybody has heard of the term "microservice", but not many people know what they are, how they work, or how to implement one.
Many people think they are a complex system that needs a lot of complex setup and management. In fact, they are a very easy way
to remove heavy lifting from your web frontend to a more appropriate place.
<!--more-->
When developing a piece of web software with microservices doing some of the heavy processing, all you need is:

* Message Queue/Bus
* 1 (or more) VM's (to install and run your service)
* 1 (or more) Web Frontend

The most basic way to explain what happens is:

1. The web frontend serialises a model, and posts that model as a message to the queue
2. A service installed on one or more VM's listens to the queue
3. A service will pick up the message from the queue, and:
    1. Deserialise it, and process it. or,
    2. Deserialise it, not be able to process it, and place it back into the queue

And that is it.

If there is more than one service, they will all be able to monitor the queue, but only one will process one message, but if there are 100s of messages, your 3 or 4 services, will process those in parallel (4 services processing a message each, rather than 1 service processing 1 at a time).

![queue based microservice architecture example][example1]

[example1]: /images/microservice-figure-1.png "queue based microservice architecture example"

As in the example above, this architecture can have different services listening to the same queue for different messages and performing different heavy duty tasks. Or simply decoupling certain critical tasks from the web frontend.

In the next post, I will show you how to create this architecture using Windows Azure, C# and dotnet core.
