# frozen_string_literal: true

module Users
  # class UsersPagesController
  class PodcastAlbumsController < UsersLayoutController
    before_action :set_podcast_album, only: %i[show edit update destroy]

    def new
      @podcast_album = PodcastAlbum.new
      render layout: false
    end

    def show
      @podcasts = @podcast_album.podcasts.order(:episode_number)
    end

    def edit
      render layout: false
    end

    def create
      @podcast_album = PodcastAlbum.new(podcast_album_params)
      @podcast_album.user_id = current_user.id
      respond_to do |format|
        if @podcast_album.save
          format.turbo_stream { flash.now[:notice] = 'Album created successfully' }
          format.html { redirect_to users_podcasts_path, notice: 'Podcast album was' }
        else
          format.turbo_stream do
            flash.now[:alert] = "<ul><li>#{@podcast_album.errors.full_messages.join('</li><li>')}</li><ul>".html_safe
          end
        end
      end
    end

    def update
      respond_to do |format|
        if @podcast_album.update(podcast_album_params)
          format.turbo_stream { flash.now[:notice] = 'Album was successfully updated.' }
          format.json { render :show, status: :ok, location: @podcast_album }
        else
          format.turbo_stream do
            flash.now[:alert] = "<ul><li>#{@podcast_album.errors.full_messages.join('</li><li>')}</li><ul>".html_safe
          end
          format.json { render json: @podcast_album.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @podcast_album.destroy

      respond_to do |format|
        format.html { redirect_to home_path, notice: 'Album was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def toggle_bookmark
      @podcast_album = PodcastAlbum.find_by(id: params[:id])
      Users::BookmarkService.call(current_user, @podcast_album)
    end

    def like
      id = params[:id] || params[:podcast_album_id]
      @podcast_album = PodcastAlbum.find_by(id:)
      LikeService.new(current_user, @podcast_album).like
    end

    private

    def set_podcast_album
      @podcast_album = PodcastAlbum.find_by(id: params[:id])
    end

    def podcast_album_params
      params.fetch(:podcast_album, {}).permit!
    end
  end
end
