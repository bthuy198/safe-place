

module Users
    # class UsersPagesController
    class PodcastAlbumsController < UsersLayoutController


      def new; 
        @podcast_album = PodcastAlbum.new
      end

      def create
        @podcast_album = PodcastAlbum.new(podcast_album_params)
        @podcast_album.user_id = current_user.id
        if @podcast_album.save
          respond_to do |format|
            format.turbo_stream
            format.html { redirect_to users_podcasts_path, notice: 'Podcast album was'}
          end
        else
          render 'new', status: :unprocessable_entity
        end
      end

      private
  
      def podcast_album_params
        params.require(:podcast_album).permit(:name)
      end
  
    end
  end
  