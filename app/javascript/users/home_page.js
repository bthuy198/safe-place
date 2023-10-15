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


  $('.radio_label').on('click', function(e) {
    e.stopPropagation();
  });


  const searchForm = document.querySelector('#search_form');
  const searchOption = document.querySelectorAll('.search_option');

  searchOption.forEach(option => {
    option.addEventListener('change', function() {
      if (this.checked) {
        searchForm.action = this.value;
        if (searchForm.action.includes('confessions')) {
          searchForm.setAttribute('data-turbo-frame', 'board');
        } else if (searchForm.action.includes('podcasts')) {
          searchForm.setAttribute('data-turbo-frame', 'main');
        }
      }
    });
  });
});

document.addEventListener("turbo:frame-missing", function(event) {
  event.preventDefault();
  event.target.remove();
});
