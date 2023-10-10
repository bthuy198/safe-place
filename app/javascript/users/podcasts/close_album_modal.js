$('#podcastAlbumModal').on('hidden.bs.modal', function (e) {
  const frame = document.querySelector('turbo-frame[id="modal_for_podcast_album"]');
  if (frame) {
    frame.innerHTML = '';
  }
});