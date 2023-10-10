$(document).ready(function () {
  $(".bookmark").on("click", function () {
    const albumId = $(this).data("album-id"); // Lấy ID của album từ thuộc tính data
    const url = "users/bookmark/" + albumId; // Đặt URL cho hành động toggle bookmark

    $.ajax({
      url: url,
      type: "POST", // Hoặc GET tùy thuộc vào cách bạn muốn xử lý
      headers: {
        "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"), // Điều này là để đảm bảo bảo mật CSRF
      },
      success: function (data) {
        // Xử lý phản hồi từ máy chủ ở đây, ví dụ cập nhật biểu tượng bookmark dựa trên dữ liệu từ máy chủ
        if (data.bookmarked) {
          $(".bookmark").attr("src", "bookmark_icon_red.svg");
        } else {
          $(".bookmark").attr("src", "bookmark_icon.svg");
        }
      },
      error: function (error) {
        console.error("Lỗi khi gửi yêu cầu: ", error);
      },
    });
  });
});
