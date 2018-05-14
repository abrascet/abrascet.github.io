/*! Abras Cet, Copyright 2018 Gabor Bata */
(function() {
  var navigationToggle = document.getElementById("navigation-toggle");
  var navigationList = document.getElementById("navigation-list");
  navigationToggle.addEventListener("click", navigationToggleHandler);
  window.addEventListener("resize", navigationResizeHandler);

  function navigationToggleHandler(event) {
    event.preventDefault();
    if (navigationList.style.display === "none") {
      navigationList.style.display = "block";
    } else {
      navigationList.style.display = "none";
    }
  }

  function navigationResizeHandler() {
    if (navigationToggle.style.display === "none") {
      navigationList.style.display = "block";
    }
  }
})();
