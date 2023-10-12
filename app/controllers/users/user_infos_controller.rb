# frozen_string_literal: true

module Users
  # class UsersPagesController
  class UserInfosController < UsersLayoutController
    before_action :authenticate_user!

    def show
      @user = current_user
      @user_info = @user.user_info
    end

    def edit
      @user = current_user
      @user_info = @user.user_info
    end

    def update
      @user = current_user
      @user_info = @user.user_info
      if @user.update(user_params)
        redirect_to users_user_infos_path, notice: 'User infomation updated successfully'
      else
        render status: :bad_request
      end
    end

    private

    def user_params
      params.require(:user).permit(:user_name, :email, :phone_number,
                                   user_info_attributes: %i[gender date_of_birth address])
    end
  end
end
