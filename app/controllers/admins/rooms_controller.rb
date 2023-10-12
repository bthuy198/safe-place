# frozen_string_literal: true

module Admins
  # class RoomsController
  class RoomsController < AdminsLayoutController
    def index
      @rooms = Room.includes(:user).all.page params[:page]
    end

    def show; end

    def new
      @room = Room.new
    end

    def edit; end

    def create
      @room = Room.new(room_params)
      @room.user_id = 22

      respond_to do |format|
        if @room.save
          format.turbo_stream
          format.html do
            redirect_to rooms_manage_rooms_path(@room), notice: 'User was successfully created.'
          end
          format.jsom { render :show, status: :created, location: @room }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @room.errors, status: :unprocessable_entity }
        end
      end
    end

    def change_status
      @room = Room.find(params[:id])
      if @room.status.nil? || (@room.status == 'disable')
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
      respond_to do |format|
        if @room.update(room_params)
          format.html do
            redirect_to rooms_manage_rooms_path(@room), notice: 'User was successfully created.'
          end
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @room.destroy
      respond_to do |format|
        # format.html { redirect_to admins_users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def room_params
      params.require(:room).permit(:name, :user_id, :counselor_id)
    end
  end
end
