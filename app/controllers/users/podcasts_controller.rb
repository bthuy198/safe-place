

module Users
    # class UsersPagesController
    class PodcastsController < UsersLayoutController

      def show; 
        @podcast_albums = PodcastAlbum.all
      end

      def new; 
        @podcast = Podcast.new
      end

      def create
        @podcast = Podcast.new(podcast_params)
        if @podcast.save
          redirect_to home_path, notice: 'Podcast infomation created successfully'
        else
          render 'new', status: :unprocessable_entity
        end
      end

      private
  
      def podcast_params
        params.fetch(:podcast, {}).permit!
      end
  
    end
  end
  