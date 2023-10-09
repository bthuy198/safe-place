$('#exampleModal').on('hidden.bs.modal', function (e) {
    console.log("bbbb")
  const frame = document.querySelector('turbo-frame[id="modal_for_podcast"]');
  if (frame) {
    frame.innerHTML = '';
  }
});