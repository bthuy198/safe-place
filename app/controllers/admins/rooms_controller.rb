# frozen_string_literal: true

module Admins
  # class RoomsController
  class RoomsController < AdminsLayoutController
    def index
      @q = Room.includes(:user).ransack(params[:q])
      @rooms = @q.result(distinct: true).order(id: :desc).page params[:page]
    end

    def show; end

    def new
      @room = Room.new
      render layout: false
    end

    def edit
      @room = Room.find(params[:id])
      # render layout: false
    end

    def create
      @room = Room.new(room_params)
      @room.status = 'disable'
      respond_to do |format|
        if @room.save
          format.turbo_stream
          # format.html do
          #   redirect_to admins_rooms_path(@room), notice: 'User was successfully created.'
          # end
          format.json { render :show, status: :created, location: @room }
        else
          flash[:alert] = @room.errors.full_messages.join(', ')
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @room.errors, status: :unprocessable_entity }
        end
      end
    end

    def change_status
      @room = Room.find(params[:id])
      if @room.status.nil? or @room.status == 'disable'
        @room.update(status: 'enable')
        flash[:success] = 'Room status changed successfully.'
      else
        @room.update(status: 'disable')
      end
      # respond_to do |format|
      #   format.js
      # end
    end

    def update
      @room = Room.find(params[:id])

      respond_to do |format|
        if @room.update(room_params)
          # format.turbo_stream
          format.html do
            redirect_to admins_rooms_path, notice: 'User was successfully created.'
          end
          format.json { render :show, status: :ok, location: @user }
        else
          flash[:alert] = @room.errors.full_messages.join(', ')
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @room = Room.find(params[:id])
      @room.destroy
      respond_to do |format|
        format.html { redirect_to admins_rooms_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def room_params
      params.require(:room).permit(:id, :name, :user_id, :counselor_id)
    end
  end
end
