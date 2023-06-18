---
title: "Observe/React to Array Changes with Angular 12"
date: 2022-04-11T22:37:34+01:00
draft: false
tags: ["angular", "angular12", "javascript", "js"]
author: ["darren horrocks"]
---

In angular 12, it is very simple to have the HTML of your component react to changes in the value of a single variable (or multiple variables).
Although it is not that simple when you want to have your components HTML react to push/pop changes.
<!--more-->

Take the following component:
```typescript
export class TitleComponent implements OnInit {
  title: string = "default title";

  constructor() { }

  ngOnInit(): void {
    this.title = "some title"
  }

  changeTitle(): void {
    this.title = "new title";
  }
}
```
```html
<div>
    <h3><span>{{ title }}</span></h3>
</div>
<button (click)="changeTitle()">CLICK ME!</button>
```
If you click the "change" button, the title will change as expected because Angular 12 watches all of your component variables for changes and reflect those changes within the HTML.

However, if you take the next component, you will find that the same thing does not happen and the HTML does not update, since angular is not able to monitor changes to an array via push/pop.
```typescript
export class StringListComponent implements OnInit {
  items: string[] = [];

  constructor() { }

  ngOnInit(): void {
    this.items = ["first item"];
  }

  addItem(): void {
    this.items.push("new item");
  }
}
```
```html
<div *ngFor="let item of items">
    <div><span>{{ item }}</span></div>
</div>
<button (click)="addItem()">CLICK ME!</button>
```

There is a very simple fix to have angular 12 react to array changes. You simply need to recreate the array for each update as below.
```typescript
export class StringListComponent implements OnInit {
  items: string[] = [];

  constructor() { }

  ngOnInit(): void {
    this.items = ["first item"];
  }

  addItem(): void {
    this.lists = [...this.items, "new item"];
  }
}
```
