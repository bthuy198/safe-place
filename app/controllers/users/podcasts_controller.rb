# frozen_string_literal: true

module Users
    # class UsersPagesController
    class PodcastsController < UsersLayoutController
      before_action :authenticate_user!, except: [:show, :index]
      before_action :set_podcast, only: %i[ show edit update destroy ]


      def index; 
        @podcast_albums = PodcastAlbum.where(user_id: current_user.id)
        @recent_podcasts = Podcast.where(podcast_album_id: @podcast_albums.pluck(:id)).limit(5)
      end

      def show
        
      end

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
            format.turbo_stream
            format.html { redirect_to home_path, notice: 'Podcast information created successfully' }
          else
            format.turbo_stream { flash.now[:alert] = @podcast.errors.full_messages.join("<br>").html_safe }
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @podcast.errors, status: :unprocessable_entity }
          end
        end
      end
      

      def destroy
        @podcast.destroy
    
        respond_to do |format|
          format.html { redirect_to home_path, notice: "Podcast was successfully destroyed." }
          format.json { head :no_content }
        end
      end

      def update
        respond_to do |format|
          if @podcast.update(podcast_params)
            format.turbo_stream
            format.html { redirect_to root_url, notice: "Podcast was successfully updated." }
            format.json { render :show, status: :ok, location: @podcast }
          else
            format.html { render :edit, status: :unprocessable_entity }
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

