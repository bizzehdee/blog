$(function() {
    $('main img').each(function(i, e) {
      $(e).wrap("<a class='fresco' href='" + $(e).attr("src") +  "'></a>");
    });
  });

  (function() {
    var links = document.querySelectorAll("a");

    for (var i = 0, linksLength = links.length; i < linksLength; i++) {
      if (links[i].hostname != window.location.hostname) {
          links[i].target = '_blank';
      } 
    }
  })();
  