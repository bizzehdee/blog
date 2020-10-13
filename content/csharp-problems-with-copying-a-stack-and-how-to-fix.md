---
title: "Problems With Copying a Stack<T> in C# and How to Fix It"
date: 2020-10-13T09:35:53+01:00
draft: false
tags: ["dotnet", "csharp", "extension-method", "code"]
author: ["darren"]
---

In C# and in .NET in general, there is a generic stack class which accepts a single type parameter. The stack class is a FILO (first in last out) collection, and can be liked to stacking plates, you cannot remove the bottom plate, without first removing all the plates above it. The problem with the ```Stack<T>``` class is that it has an ```IEnumerable<T>``` constructor...
<!--more-->

This constructor suggests that whatever collection is passed to it, is copied exactly to the new stack. The problem is, it is both true and not true at the same time, especially if you are copying another stack.

If you pass a stack to another stack and expect to have the same stack twice, you will start to run into problems.

If we init a stack like this:
```csharp
var firstStack = new Stack<int>();
firstStack.Push(1);
firstStack.Push(2);
firstStack.Push(3);
```

You will end up with 1 at the bottom of the stack, 2 on top of 1 and then 3 at the top of the stack.

If you then want to copy that stack to another stack, you would assume this is correct:
```csharp
var secondStack = new Stack<int>(firstStack);
```

You would assume that ```secondStack``` would also end up with 1 at the bottom of the stack, 2 on top of 1, and 3 at the top of the stack, but this is wrong. What actually happens is the reverse of this. 3 ends up at the bottom of the stack, 2 in the middle and 1 at the top.

The reason for this is that in converting the ```Stack<T>``` to an ```IEnumerable<T>```, what essentially happens is, the old stack is itterated from top to bottom, rather than bottom to top. This has the effect of the last item added to the first stack, becoming the first item that is added to the new stack, essentially reversing the stack in the copy.

To get around this, the most simple option when copying a stack, is to double copy the stack (though with large stacks, this is not the most efficient), and an extension method for doing this can be as follows:

```csharp
public static Stack<T> Clone<T>(this Stack<T> originalStack)
{
    return new Stack<T>(new Stack<T>(originalStack));
}
```

This has the effect of reversing the stack, and then reversing it again in a second copy. The inner stack and its items will be released by the GC very quickly, and we now have a method which we can use to clone a ```Stack<T>```.
