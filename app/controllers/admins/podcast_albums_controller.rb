# frozen_string_literal: true

module Admins
class PodcastAlbumsController < AdminsLayoutController
  before_action :set_podcast_album, only: %i[show edit update destroy]

  # GET /podcast_albums or /podcast_albums.json
  def index
    @podcast_albums = PodcastAlbum.all
  end

  # GET /podcast_albums/1 or /podcast_albums/1.json
  def show; end

  # GET /podcast_albums/new
  def new
    @podcast_album = PodcastAlbum.new
  end

  # GET /podcast_albums/1/edit
  def edit; end

  # POST /podcast_albums or /podcast_albums.json
  def create
    @podcast_album = PodcastAlbum.new(podcast_album_params)

    respond_to do |format|
      if @podcast_album.save
        format.html { redirect_to podcast_album_url(@podcast_album), notice: 'Podcast album was successfully created.' }
        format.json { render :show, status: :created, location: @podcast_album }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @podcast_album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /podcast_albums/1 or /podcast_albums/1.json
  def update
    respond_to do |format|
      if @podcast_album.update(podcast_album_params)
        format.html { redirect_to podcast_album_url(@podcast_album), notice: 'Podcast album was successfully updated.' }
        format.json { render :show, status: :ok, location: @podcast_album }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @podcast_album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /podcast_albums/1 or /podcast_albums/1.json
  def destroy
    @podcast_album.destroy

    respond_to do |format|
      format.html { redirect_to podcast_albums_url, notice: 'Podcast album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_podcast_album
    @podcast_album = PodcastAlbum.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def podcast_album_params
    params.fetch(:podcast_album, {})
  end
end
end
