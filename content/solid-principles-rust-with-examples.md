---
title: "SOLID Design Principles Rust (with examples)"
date: 2024-10-25T10:31:56+01:00
draft: false
tags: ["rust", "solid", "programming"]
author: ["darren horrocks"]
---

When it comes to designing software, the SOLID principles are the gold standard for object-oriented programming. While Rust isn’t an object-oriented language in the strictest sense, it offers plenty of tools to apply SOLID principles effectively. With enums, traits, and strict type safety, Rust provides a solid foundation for building flexible, maintainable, and robust applications that adhere to these design principles.
<!--more-->

#### **Single Responsibility Principle (SRP)**

The Single Responsibility Principle states that a struct or function should have one, and only one, reason to change. In Rust, this translates into modules, structs, and functions that each handle a single task.

For example, consider a simple logging system:

```rust
// Logger only handles logging.
struct Logger;

impl Logger {
    fn log(&self, message: &str) {
        println!("Log: {}", message);
    }
}

// FileProcessor is responsible for file processing only.
struct FileProcessor {
    logger: Logger,
}

impl FileProcessor {
    fn process_file(&self, filename: &str) {
        // Process the file (e.g., reading content)
        self.logger.log("Processing file...");
    }
}
```

Here, `Logger` handles logging, and `FileProcessor` processes files. By separating these responsibilities, we make each component independently modifiable and testable.

---

#### **Open/Closed Principle (OCP)**

The Open/Closed Principle states that modules should be open for extension but closed for modification. In Rust, this often involves using enums or trait-based polymorphism.

Consider a payment system with multiple payment methods:

```rust
trait Payment {
    fn pay(&self, amount: f32);
}

struct CreditCard;
impl Payment for CreditCard {
    fn pay(&self, amount: f32) {
        println!("Paid ${} with credit card.", amount);
    }
}

struct Paypal;
impl Payment for Paypal {
    fn pay(&self, amount: f32) {
        println!("Paid ${} using PayPal.", amount);
    }
}

fn process_payment(payment: &dyn Payment, amount: f32) {
    payment.pay(amount);
}
```

Here, `Payment` is a trait that new payment methods can implement without modifying existing code. By adhering to OCP, we make it easy to add new payment methods without disrupting the existing `process_payment` logic.

---

#### **Liskov Substitution Principle (LSP)**

The Liskov Substitution Principle asserts that objects of a superclass should be replaceable with objects of a subclass without altering the correctness of the program. In Rust, this is less about inheritance and more about implementing traits in a consistent way.

Imagine an example of drawing shapes:

```rust
trait Drawable {
    fn draw(&self);
}

struct Circle;
impl Drawable for Circle {
    fn draw(&self) {
        println!("Drawing a circle.");
    }
}

struct Square;
impl Drawable for Square {
    fn draw(&self) {
        println!("Drawing a square.");
    }
}

fn render_shape(shape: &dyn Drawable) {
    shape.draw();
}
```

Both `Circle` and `Square` implement the `Drawable` trait, making them interchangeable in `render_shape`. Thus, we follow the LSP by ensuring both types can replace each other in code that uses `Drawable`.

---

#### **Interface Segregation Principle (ISP)**

The Interface Segregation Principle says that clients should not be forced to depend on interfaces they don’t use. In Rust, this is typically achieved by using smaller, focused traits.

Consider a printer and scanner:

```rust
trait Printer {
    fn print(&self, document: &str);
}

trait Scanner {
    fn scan(&self) -> String;
}

struct AllInOneDevice;

impl Printer for AllInOneDevice {
    fn print(&self, document: &str) {
        println!("Printing: {}", document);
    }
}

impl Scanner for AllInOneDevice {
    fn scan(&self) -> String {
        "Scanned document content".to_string()
    }
}
```

Here, we separate the `Printer` and `Scanner` traits, allowing devices that only print or scan to implement only what they need. This keeps the interface minimal and clean, aligning with the ISP.

---

#### **Dependency Inversion Principle (DIP)**

The Dependency Inversion Principle promotes depending on abstractions, not concretions. In Rust, traits provide a great way to inject dependencies and reduce coupling between modules.

Consider a notification system where we can notify users via email or SMS:

```rust
trait Notifier {
    fn send(&self, message: &str);
}

struct EmailNotifier;
impl Notifier for EmailNotifier {
    fn send(&self, message: &str) {
        println!("Sending email: {}", message);
    }
}

struct SmsNotifier;
impl Notifier for SmsNotifier {
    fn send(&self, message: &str) {
        println!("Sending SMS: {}", message);
    }
}

struct UserNotifier<'a> {
    notifier: &'a dyn Notifier,
}

impl<'a> UserNotifier<'a> {
    fn notify_user(&self, message: &str) {
        self.notifier.send(message);
    }
}
```

By using a trait (`Notifier`) as an abstraction, we can easily inject any type of notifier (`EmailNotifier`, `SmsNotifier`) into `UserNotifier`. This flexibility makes the code easier to test and extend.
