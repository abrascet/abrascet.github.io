/*! Abras Cet, Copyright 2018 Gabor Bata */
(function() {
  var navigationToggle = document.getElementById("navigation-toggle");
  var navigationList = document.getElementById("navigation-list");

  // based on: https://www.quirksmode.org/dom/getstyles.html#link7
  function getDisplayStyle(element) {
    var displayStyle;
    if (element.currentStyle) {
      displayStyle = element.currentStyle.display;
    } else if (window.getComputedStyle) {
      displayStyle = window.getComputedStyle(element, null).getPropertyValue("display");
    }
    return displayStyle;
  }

  function navigationToggleHandler(event) {
    event.preventDefault();
    if (getDisplayStyle(navigationList) === "none") {
      navigationList.style.display = "block";
    } else {
      navigationList.style.display = "none";
    }
  }

  function navigationResizeHandler() {
    if (getDisplayStyle(navigationToggle) === "none") {
      navigationList.style.display = "block";
    } else {
      navigationList.style.display = "none";
    }
  }

  if (!!navigationToggle) {
    navigationToggle.addEventListener("click", navigationToggleHandler);
  }
  if (!!navigationList) {
    window.addEventListener("resize", navigationResizeHandler);
  }
})();

// keyboard navigation
(function() {
  var pagination = document.getElementsByClassName('pagination');
  pagination = pagination.length > 0 ? pagination[0] : null;

  function navigateWithButton(idx) {
    var href = pagination.getElementsByClassName('button')[idx].href;
    if (!!href) {
      window.location = href;
    }
  }

  document.onkeydown = function(evt) {
    evt = evt || window.event;
    if (!pagination || evt.target.nodeName == 'INPUT' || evt.altKey || evt.shiftKey || evt.ctrlKey || evt.metaKey) {
      return;
    } else if (evt.keyCode == 37) {
      navigateWithButton(1);
    } else if (evt.keyCode == 39) {
      navigateWithButton(2);
    }
  };
})();
