---
title: "What is the difference betwen Promises and Observables in angular?"
date: 2023-09-24T08:52:45+01:00
draft: false
author: ["darren horrocks"]
tags: ["angular", "javascript", "js"]
---

In Angular, Promises and Observables are both used for handling asynchronous operations, but they have some key differences in how they work and what they offer. Here are the main distinctions between the two:

<!--more-->

## Primises

* **Single Value:** A Promise represents a single future value. It's a proxy for a value not necessarily known when the promise is created.

* **Eager:** Promises are eager, meaning that they immediately start executing when they are created.

* **Not Cancellable:** Once a promise is created, it cannot be cancelled.

* **One-time:** A Promise can only emit a single value, either a resolved value or a rejected reason.

* **.then() syntax:** Promises are typically handled using ```.then()``` and ```.catch()```.

```javascript
someAsyncFunction()
  .then(result => {
    // Do something with the result
  })
  .catch(error => {
    // Handle errors
  });
```

## Observables

* **Multiple Values:** An Observable is a stream of values that may be emitted over time. It can emit zero or more values.

* **Lazy:** Observables are lazy, meaning they do not start emitting values until a subscription is made.

* **Cancellable:** You can cancel an observable by unsubscribing.

* **Continuous:** An Observable can keep emitting values over time, which makes it suitable for handling events or continuous streams of data.

* **.subscribe() syntax:** Observables are typically handled using ```.subscribe()```.

```javascript
someAsyncObservable()
  .subscribe(
    value => {
      // Do something with each emitted value
    },
    error => {
      // Handle errors
    },
    () => {
      // Handle completion (optional)
    }
  );
```

## When to Use Which

* **Promises** are suitable for operations that produce a single value. They are a good fit for scenarios where you make a single asynchronous request and expect a single response.

* **Observables** are more powerful when dealing with multiple values or streams of data. They are especially useful for handling events, continuous data streams (like from WebSockets), and scenarios where you might need to cancel or transform the data before it reaches the subscriber.

In Angular, HTTP requests using the HttpClient return Observables by default, which allows you to leverage the full power of Observables for handling the asynchronous nature of HTTP requests.

In summary, if you're dealing with a single asynchronous operation, a Promise might be sufficient. However, if you're working with streams of data, events, or need more control over cancellation, Observables are the way to 