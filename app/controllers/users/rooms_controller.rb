# frozen_string_literal: true

module Users
  # class UsersPagesController
  class RoomsController < UsersLayoutController
    before_action :authenticate_user!

    def index
      @q = Room.includes(:user).ransack(params[:q])
      @rooms = @q.result(distinct: true).order(id: :desc).page params[:page]
    end

    def join_room
      @room = Room.find(params[:id])

      if @room.update(user_id: current_user.id)
        render json: { message: 'success', status: 200 }, status: :ok
      # redirect_to in_room_users_room_path(@room)
      else
        render json: { message: 'Failed to join room.' }, status: :unprocessable_entity
      end
    end

    def out_room
      # binding.pry
      @room = Room.find(params[:id])

      if @room.update(user_id: nil)
        render json: { message: 'success', status: 200 }, status: :ok

      else
        render json: { error: 'Failed to join room.' }, status: :unprocessable_entity
      end
    end

    def room_chat
      @room = Room.find(params[:id])
    end

    private

    def room_params
      params.require(:room).permit(:name, :user_id, :counselor_id)
    end
  end
end
