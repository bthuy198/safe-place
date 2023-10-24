# frozen_string_literal: true

module Users
  # class UsersPagesController
  class RoomsController < UsersLayoutController
    before_action :authenticate_user!

    def index
      @q = Room.includes(:user).where(status: :enable).ransack(params[:q])
      @rooms = @q.result.order(id: :desc).page params[:page]
    end

    def show
      @room = if current_user.type == 'User'
                Room.find_by(id: params[:id], user_id: current_user.id)
              else
                Room.find_by(id: params[:id], counselor_id: current_user.id)
              end
      render layout: 'blank_layout/user_blank'
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

    # def out_room
    #   @room = Room.find(params[:id])
    #   if @room.update(user_id: nil)
    #     redirect_to users_counselors_path
    #     Turbo::StreamsChannel.broadcast_replace_to('room',
    #                                                partial: 'users/rooms/partials/room_chat',
    #                                                locals: { room: @room },
    #                                                target: "button_join_#{@room.id}")

    #   else
    #     render json: { error: 'Failed to out room.' }, status: :unprocessable_entity
    #   end
    # end

    private

    def room_params
      params.require(:room).permit(:name, :user_id, :counselor_id)
    end
  end
end
