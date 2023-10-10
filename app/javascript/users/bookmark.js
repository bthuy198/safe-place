$(document).ready(function () {
  $(".bookmark").on("click", function () {
    console.log("Bookmark clicked");
    const albumId = $(this).data("album-id");
    const url = "/users/podcast_albums/" + albumId + "/toggle_bookmark";

    const bookmarkIcon = $(this);

    bookmarkIcon.toggleClass("bookmark-clicked");

    $.ajax({
      url: url,
      type: "POST",
      headers: {
        "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
      },
      success: function (data) {
        if (data.bookmarked) {
          bookmarkIcon.attr("src", " /assets/bookmark_icon_red.svg");
        } else {
          bookmarkIcon.attr("src", " /assets/bookmark_icon.svg");
        }
        setTimeout(function () {
          bookmarkIcon.removeClass('bookmark-clicked');
        }, 300); 
      },
      error: function (error) {
        console.error("Lỗi khi gửi yêu cầu: ", error);
      },
    });
  });
});
