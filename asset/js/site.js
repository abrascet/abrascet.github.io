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
