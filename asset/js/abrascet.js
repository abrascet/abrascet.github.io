/*! Copyright (c) 2018 abrascet */
(function() {
  var navToggle = document.getElementById("navigation-toggle");
  var navList = document.getElementById("navigation-list");
  navToggle.addEventListener('click', toggleHandler);
  window.addEventListener('resize', resizeHandler);

	function toggleHandler(event) {
		event.preventDefault();
    if (navList.style.display === "none") {
      navList.style.display = "block";
    } else {
      navList.style.display = "none";
    }
  }

  function resizeHandler(event) {
    if (navToggle.style.display === "none") {
      navList.style.display = "block";
    }
  }

})();
