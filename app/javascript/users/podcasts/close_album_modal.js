$('#podcastAlbumModal').on('hidden.bs.modal', function (e) {
    console.log("aaaa")
  const frame = document.querySelector('turbo-frame[id="modal_for_podcast_album"]');
  if (frame) {
    frame.innerHTML = '';
  }
});