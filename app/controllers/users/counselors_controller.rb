module Users
    class CounselorsController < UsersLayoutController
        before_action :authenticate_user!
        def index
            @q = Counselor.ransack(params[:q])
            @counselors = @q.result(distinct: true).order(id: :desc).page params[:page]
        end

        def join_counseler_room
            counselor_id = params[:id]
            rooms = Room.where(counselor_id: counselor_id, status: 'enable')
            room_joined = rooms.find_by(user_id: current_user.id )
            if room_joined
                redirect_to users_room_path(room_joined)
            elsif rooms.where(user_id: nil).exists?
                room_to_join = rooms.where(user_id: nil).first
                room_to_join.update(user_id: current_user.id)
                redirect_to users_room_path(room_to_join)
            else
                new_room = Room.create(user_id: current_user.id, name: "room#{current_user.id}", counselor_id: counselor_id, status: 'enable')
                redirect_to users_room_path(new_room)
            end
        end

        def notfound_room; end
    end
end