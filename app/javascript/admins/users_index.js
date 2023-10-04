$(document).on("change", ".anonymous-switch", function () {
  var userId = $(this).attr("id").replace("user_anonymous_", "");
  var isChecked = $(this).prop("checked");
  var url = "/admins/users/" + userId + "/toggle_anonymous";

  $.ajax({
    type: "PATCH",
    url: url,
    data: { anonymous: isChecked },
    success: function (data) {
      console.log('The "Anonymous" status has been updated successfully.');
    },
    error: function () {
      console.log('An error occurred while updating the "Anonymous" status.');
    },
  });
});
