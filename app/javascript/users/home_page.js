function moveForward() {
    window.history.forward();
}
function moveBackward() {
    window.history.back();
}

document.addEventListener('DOMContentLoaded', function() {
  const targetElement = document.querySelector('.custom_render_row');

  function handleViewportChange(mq) {
    if (mq.matches) {
      targetElement.style.display = 'flex';
      targetElement.style.flexDirection = 'column-reverse';
    } else {
      targetElement.style.display = '';
      targetElement.style.flexDirection = '';
    }
  }

  const mq = window.matchMedia('(max-width: 767px)');
  handleViewportChange(mq);

  mq.addEventListener('change', handleViewportChange);
});

document.addEventListener("turbo:frame-missing", function(event) {
  event.preventDefault();
  event.target.remove();
});
