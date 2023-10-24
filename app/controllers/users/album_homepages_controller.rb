# frozen_string_literal: true

module Users
  # class AlbumHomePagesController
  class AlbumHomepagesController < UsersLayoutController
    def index
      if params[:q]
        @q = PodcastAlbum.ransack(user_user_name_or_name_cont: params[:q])
        @albums = @q.result.includes(:user)
      else
        @albums = PodcastAlbum.joins(:podcasts).distinct.limit(6)
        @recent_albums = PodcastAlbum.joins(:podcasts).distinct.order(created_at: :desc).limit(6)
      end
    end

    def show
      @album = PodcastAlbum.find_by(id: params[:id])
      @podcasts = @album.podcasts.order(:episode_number)
      render layout: false
    end

    def all_album
      @albums = PodcastAlbum.all
    end
  end
end
