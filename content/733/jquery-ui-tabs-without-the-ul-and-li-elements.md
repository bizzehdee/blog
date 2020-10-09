---
title: "jQuery UI Tabs without the ul and li elements"
date: 2012-04-25T20:00:00+01:00
draft: true
author: ["darren"]
---

Something really annoys me about jQuery UI and how its markup is laid out, especially around tabs.
<!--more-->

```html
<div class="tabs">
<ul>
<li><a href="#tab-1">Tab 1</a></li>
<li><a href="#tab-2">Tab 2</a></li>
<li><a href="#tab-3">Tab 3</a></li>
</ul>
<div id="tab-1">
</div>
<div id="tab-2">
</div>
<div id="tab-3">
</div>
</div>
```
You can use

```html
<div class="tabs">
<div id="tab-1" title="Tab 1">
</div>
<div id="tab-2" title="Tab 2">
</div>
<div id="tab-3" title="Tab 3">
</div>
</div>
```

Using the simple code below with jquery+jqueryui, you can remove the need entirely for the ul and li elements.

```javascript
$('.tabs').each(function() {
    var m_ul = $('<ul/>');
    $(this).children('div[title]').each(function() {
        var m_id = ($(this).attr('id') != undefined ? $(this).attr('id') : $(this).attr('title').replace(/\s/g, '_'));
        $(this).attr('id', m_id);
        $(m_ul).append($('<li/>').append($('<a/>').attr('href', '#' + m_id).text($(this).attr('title'))));
    });
    $(this).prepend(m_ul);
}).tabs();
```