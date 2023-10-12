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
      iconElement.toggleClass("fill-red");
    }

    iconElement.toggleClass("stroke-red");

    setTimeout(function () {
      iconElement.removeClass("bookmark-clicked");
    }, 300);
  }

  $(".bookmark_podcast_albums").on("click", function () {
    const url =
      "/users/podcast_albums/" + $(this).data("album-id") + "/toggle_bookmark";
    toggleIcon($(this), url, "bookmark");
  });

  $(".heart_podcast_albums").on("click", function () {
    const url = "/users/podcast_albums/" + $(this).data("album-id") + "/like";
    toggleIcon($(this), url, "heart");
  });

  $("#play-pause-icon").click(function () {
    var icon = $(this);

    if (icon.hasClass("play")) {
      icon
        .removeClass("fa-solid fa-circle-play play")
        .addClass("fa-solid fa-circle-pause pause");
    } else {
      icon
        .removeClass("fa-solid fa-circle-pause pause")
        .addClass("fa-solid fa-circle-play play");
    }
  });
});
