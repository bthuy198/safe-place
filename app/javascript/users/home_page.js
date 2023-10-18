document.addEventListener('turbo:load', function() {
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

document.addEventListener("turbo:before-stream-render", (event) => {
  if(event.detail.newStream.getAttribute("action")=="remove") {
    let target_id = event.detail.newStream.getAttribute("target")
    if(target_id.includes("confession")) {
      let target = document.getElementById(target_id)
    let modal = target.children[2].children[2]
    $(modal).modal("hide")
    }
  }
})
