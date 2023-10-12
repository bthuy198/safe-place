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
        redirect_to room_chat_users_room_path(@room)
        Turbo::StreamsChannel.broadcast_replace_to('room',
                                                   partial: 'users/rooms/partials/disable_room_chat',
                                                   locals: { room: @room },
                                                   target: "button_join_#{@room.id}")
      else
        render json: { message: 'Failed to join room.' }, status: :unprocessable_entity
      end
    end

    def out_room
      @room = Room.find(params[:id])

      if @room.update(user_id: nil)
        # render json: { message: 'success', status: 200 }, status: :ok
        redirect_to users_rooms_path
        Turbo::StreamsChannel.broadcast_replace_to('room',
                                                   partial: 'users/rooms/partials/room_chat',
                                                   locals: { room: @room },
                                                   target: "button_join_#{@room.id}")
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
