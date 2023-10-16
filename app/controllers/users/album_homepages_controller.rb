# frozen_string_literal: true

module Users
  # class AlbumHomePagesController
  class AlbumHomepagesController < UsersLayoutController
    def index
      @albums = PodcastAlbum.limit(6)
      @recent_albums = PodcastAlbum.order(created_at: :desc).limit(6)
    end

    def show
      @album = PodcastAlbum.find_by(id: params[:id])
      @podcasts = @album.podcasts.order(:episode_number)
    end

    def all_album
      @albums = PodcastAlbum.all
    end
  end
end
