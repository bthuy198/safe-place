# frozen_string_literal: true

module Users
  # class UsersPagesController
  class PodcastsController < UsersLayoutController
    before_action :authenticate_user!
    before_action :set_podcast, only: %i[show edit update destroy]

    def index
      @podcast_albums = PodcastAlbum.where(user_id: current_user.id)
      @recent_podcasts = Podcast.where(podcast_album_id: @podcast_albums.pluck(:id)).limit(5)
    end

    def show; end

    def new
      @podcast = Podcast.new
      render layout: false
    end

    def edit
      render layout: false
    end

      def create
        @podcast = Podcast.new(podcast_params)
        respond_to do |format|
          if @podcast.save
            format.turbo_stream {flash.now[:notice] = 'Podcast created successfully'  }
            format.html { redirect_to home_path, notice: 'Podcast information created successfully' }
          else
            format.turbo_stream {  flash.now[:alert] = "<ul><li>#{@podcast.errors.full_messages.join("</li><li>")}</li><ul>".html_safe  }
            format.json { render json: @podcast.errors, status: :unprocessable_entity }
          end
        end
      end
      

    def destroy
      @podcast.destroy

      respond_to do |format|
        format.html { redirect_to home_path, notice: 'Podcast was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

      def update
        respond_to do |format|
          if @podcast.update(podcast_params)
            format.turbo_stream { flash.now[:notice] = 'Podcast updated successfully'}
            format.json { render :show, status: :ok, location: @podcast }
          else
            format.turbo_stream { flash.now[:alert] = "<ul><li>#{@podcast.errors.full_messages.join("</li><li>")}</li><ul>".html_safe }
            format.json { render json: @podcast.errors, status: :unprocessable_entity }
          end
        end
      end

    private
    def set_podcast
      @podcast = Podcast.find(params[:id])
    end

    def podcast_params
      params.fetch(:podcast, {}).permit!
    end
  end
end
