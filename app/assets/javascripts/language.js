$(".language-selector .flag-link").click(function (e) {
  e.preventDefault(); // Empêche le lien de suivre son URL

  var href = $(this).attr("href");
  var lang = href.split("/")[1]; // Extrait la langue de l'URL

  // Redirige vers la même page avec la nouvelle langue
  window.location.href =
    "/" + lang + window.location.pathname + window.location.search;
});
