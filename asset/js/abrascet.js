/*! Copyright (c) 2018 abrascet */
(function() {
  var navToggle = document.getElementById("navigation-toggle");
  var navList = document.getElementById("navigation-list");
  navToggle.addEventListener('click', toggle);

	function toggle(event) {
		event.preventDefault();
    if (navList.style.display === "none") {
      navList.style.display = "block";
    } else {
      navList.style.display = "none";
    }
  }

})();
