function loadNewPlaylistPodcast(newListPodcast, currentPodcastIndex) {
  podcasts = [];
  const podcastList = $("#podcast-list");
  podcastList.empty();
  newListPodcast.forEach(function (podcast) {
    podcasts.push(podcast);
    const imageSrc =
      podcast.image && podcast.image.url
        ? podcast.image.url
        : "/assets/podcast_default.jpg";

    const listItem = `<li class="list-group-item podcast-list-item" data-index="${podcast.id}">
      <div class="d-flex align-items-center">
        <span class="m-2">
          <img class="playlist_podcast_image" width="100" height="100" src="${imageSrc}"></img>
        </span>
        <span class="m-2">
          <p class="m-0 fs-5 fw-bold playlist_podcast_name">${podcast.name}</p>
          <p class="m-0 fw-lighter text_opacity_50 playlist_podcast_author">${podcast.author_name}</p>
        </span>
        <span class="ms-auto">
          <i class="music_icon fa-solid fa-music fa-xl" style="color: #1f7564;" data-index="${podcast.id}"></i>
        </span>
      </div>
    </li>`;

    podcastList.append(listItem);
  });

  loadPodcast(currentPodcastIndex);
  $(".podcast-list-item").on("click", podcastListItemClick);
}

function podcastListItemClick() {
  const index = $(this).data("index");
  currentPodcastIndex = podcasts.findIndex((podcast) => podcast.id === index);
  loadPodcast(currentPodcastIndex);
}

function loadPodcast(index) {
  currentPodcast = podcasts[index];
  currentPodcastIndex = index;
  loadAudio(currentPodcast);
  displayPodcastInfo(currentPodcast);
  manageHeartIcon(currentPodcast);
  manageBookmarkIcon(currentPodcast);
  highlightCurrentPodcast(currentPodcast.id);
  updateMediaFrameVisibility();
  const durationFormattedTime = formatTime(currentPodcast.duration);
  $("#audio_max_time")[0].textContent = durationFormattedTime;
}

function highlightCurrentPodcast(currentId) {
  $(".music_icon").each(function () {
    if (currentId === $(this).data("index")) {
      $(this).addClass("fa-beat");
    } else {
      $(this).removeClass("fa-beat");
    }
  });
}

function loadAudio(podcast) {
  audioPlayer.src = podcast.audio.url;
  audioPlayer.oncanplaythrough = function () {
    audioPlayer.play();
    $("#play-pause-icon")
      .removeClass("fa-circle-play")
      .addClass("fa-circle-pause");
  };
}

function displayPodcastInfo(podcast) {
  $("#podcast_name").text(podcast.name);
  const podcastImage = $("#podcast_image");
  $("#podcast_author").text(podcast.author_name);

  if (podcast.image.url) {
    podcastImage[0].src = podcast.image.url;
  } else {
    podcastImage[0].src = "/assets/podcast_default.jpg";
  }
}

function manageHeartIcon(podcast) {
  const heartIcon = $("#heart_podcast");
  heartIcon.data("id", podcast.id);
  if (listLikedPodcastItem.includes(podcast.id)) {
    heartIcon.addClass("fill-red stroke-red").removeClass("stroke-opacity-50");
  } else {
    heartIcon.removeClass("fill-red stroke-red").addClass("stroke-opacity-50");
  }
}

function manageBookmarkIcon(podcast) {
  const bookmarkIcon = $("#bookmark_podcast");
  bookmarkIcon.data("id", podcast.id);
  if (listBookmarkedPodcastItem.includes(podcast.id)) {
    bookmarkIcon.addClass("stroke-red").removeClass("stroke-opacity-50");
  } else {
    bookmarkIcon.removeClass("stroke-red").addClass("stroke-opacity-50");
  }
}

function playPodcast() {
  if (audioPlayer.src !== "") {
    $("#play-pause-icon")
      .removeClass("fa-circle-play")
      .addClass("fa-circle-pause");
    audioPlayer.play();
  }
}

function pausePodcast() {
  $("#play-pause-icon")
    .removeClass("fa-circle-pause")
    .addClass("fa-circle-play");
  audioPlayer.pause();
}

function updateMediaFrameVisibility() {
  var mediaFrame = $("turbo-frame[id=media]");
  if (audioPlayer.src === "") {
    mediaFrame.hide();
  } else {
    mediaFrame.show();
  }
}

function forwardFifteenSeconds() {
  audioPlayer.currentTime += 15;
}

function rewindFifteenSeconds() {
  audioPlayer.currentTime -= 15;
}

function adjustAudioSeek() {
  const seekTo = audioPlayer.duration * ($("#seek-slider").val() / 100);
  audioPlayer.currentTime = seekTo;
}

function updateAudioTime() {
  currentTimePlaying = audioPlayer.currentTime;
  const duration = audioPlayer.duration;

  const currentFormattedTime = formatTime(currentTimePlaying);

  const seekValue = (currentTimePlaying / duration) * 100;
  $("#seek-slider").val(seekValue);
  audioCurrentTimeText.textContent = currentFormattedTime;
}

function formatTime(time) {
  const minutes = Math.floor(time / 60);
  const seconds = Math.floor(time - minutes * 60);
  return `${minutes}:${seconds < 10 ? "0" : ""}${seconds}`;
}

function playPreviousPodcast() {
  currentPodcastIndex =
    (currentPodcastIndex - 1 + podcasts.length) % podcasts.length;
  loadPodcast(currentPodcastIndex);
}

function playNextPodcast() {
  currentPodcastIndex = (currentPodcastIndex + 1) % podcasts.length;
  loadPodcast(currentPodcastIndex);
}

function selectPodcastItem(item) {
  const index = item.data("audio").id;
  currentPodcastIndex = podcasts.findIndex((podcast) => podcast.id === index);
  loadPodcast(currentPodcastIndex);
}

var currentPodcastIndex = currentPodcastIndex || 0;
var audioPlayer = audioPlayer || $("#audio-player")[0];
var podcasts = podcasts || [];
var currentPodcast = currentPodcast || null;
var currentTimePlaying = currentTimePlaying || 0;
var audioCurrentTimeText = $("#audio_current_time")[0];
var isPlaying = isPlaying || false;

if (
  currentPodcastIndex !== undefined &&
  audioPlayer &&
  Array.isArray(podcasts) &&
  currentPodcast !== null
) {
  loadNewPlaylistPodcast(podcasts, currentPodcastIndex);
  audioPlayer.currentTime = currentTimePlaying;
  console.log(!isPlaying);
  if (!isPlaying) pausePodcast();
}

$(document).ready(function () {
  $(document).off("click", "#play-pause-icon");
  $(document).off("input", "#seek-slider");
  $(document).off("input", "#volume-slider");
  $(document).off("click", "#forward-button");
  $(document).off("click", "#rewind-button");
  $(document).off("click", "#prev-button");
  $(document).off("click", "#next-button");
  $(document).off("click", ".podcast-item");
  $(document).off("click", "#bookmark_podcast");
  $(document).off("click", "#heart_podcast");

  $("#play-pause-icon").on("click", function () {
    if ($(this).hasClass("fa-circle-play")) {
      if (audioPlayer.src !== "") {
        playPodcast();
      }
    } else if ($(this).hasClass("fa-circle-pause")) {
      pausePodcast();
    }
  });

  audioPlayer.onplay = function () {
    isPlaying = true;
    $("#play-pause-icon")
      .removeClass("fa-circle-play")
      .addClass("fa-circle-pause");
  };

  audioPlayer.onpause = function () {
    isPlaying = false;
    $("#play-pause-icon")
      .removeClass("fa-circle-pause")
      .addClass("fa-circle-play");
  };

  $("#seek-slider").on("input", function () {
    adjustAudioSeek();
  });

  audioPlayer.addEventListener("ended", function () {
    playNextPodcast();
  });

  audioPlayer.addEventListener("timeupdate", updateAudioTime);

  $("#volume-slider").on("input", function () {
    audioPlayer.volume = $(this).val();
  });

  $("#forward-button").on("click", function () {
    forwardFifteenSeconds();
  });

  $("#rewind-button").on("click", function () {
    rewindFifteenSeconds();
  });

  $("#prev-button").on("click", function () {
    playPreviousPodcast();
  });

  $("#next-button").on("click", function () {
    playNextPodcast();
  });

  $(".podcast-item").on("click", function () {
    selectPodcastItem($(this));
  });

  $("#bookmark_podcast").on("click", function () {
    $(this).toggleClass("stroke-opacity-50");
    handleBookmarkPodcastClick($(this));
  });

  $("#heart_podcast").on("click", function () {
    $(this).toggleClass("stroke-opacity-50");
    handleLikePodcastClick($(this));
  });

  updateMediaFrameVisibility();
});
