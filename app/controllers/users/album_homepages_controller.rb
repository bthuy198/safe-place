# frozen_string_literal: true

module Users
    class AlbumHomepagesController < UsersLayoutController
      
      def index
        @albums = PodcastAlbum.limit(5)
        @recent_albums = PodcastAlbum.order(created_at: :desc).limit(5)
      end

      def show
        @album = PodcastAlbum.find(params[:id])
      end
  
    end
  end
  