$(document).ready(function () {
  function toggleIcon(iconElement, url, cssClass) {
    iconElement.toggleClass("bookmark-clicked");

    $.ajax({
      url: url,
      type: "POST",
      headers: {
        "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
      },
    });

    if (cssClass === "heart") {
      iconElement.toggleClass("fill-red", !iconElement.hasClass("stroke-red"));
    }

    iconElement.toggleClass("stroke-red");

    setTimeout(function () {
      iconElement.removeClass("bookmark-clicked");
    }, 300);
  }

  $(".bookmark").on("click", function () {
    const url =
      "/users/podcast_albums/" + $(this).data("album-id") + "/toggle_bookmark";
    toggleIcon($(this), url, "bookmark");
  });

  $(".heart").on("click", function () {
    const url = "/users/podcast_albums/" + $(this).data("album-id") + "/like";
    toggleIcon($(this), url, "heart");
  });
});
