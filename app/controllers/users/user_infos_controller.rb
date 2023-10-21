# frozen_string_literal: true

module Users
  # class UsersPagesController
  class UserInfosController < UsersBlankLayoutController
    before_action :authenticate_user!


    def show
      @user = current_user
    end

    def edit
      @user = current_user
    end

    def update
      @user = current_user
      if @user.update(user_params)
        redirect_to users_user_infos_path, notice: 'User infomation updated successfully'
      else
        redirect_to users_user_infos_path, alert: @user.errors.full_messages.join(", ")
      end
    end

    private

    def user_params
      params.require(:user).permit(:user_name, :phone_number,
                                   user_info_attributes: %i[id gender date_of_birth address avatar])
    end
  end
end
