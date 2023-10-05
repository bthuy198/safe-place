# frozen_string_literal: true

module Admins
  # Class UsersController for Admins
  class UsersController < AdminsLayoutController
    before_action :set_user, only: %i[show edit update destroy]

    DEFAULT_PASSWORD = '123456'

    def index
      @q = User.where(type: :User).includes(:user_info).ransack(params[:q])
      @users = @q.result(distinct: true).order(id: :desc).page params[:page]
    end

    def index_counselors
      @q = User.where(type: :Counselor).includes(:user_info).ransack(params[:q])
      @counselors = @q.result(distinct: true).order(id: :desc).page params[:page]
    end

    def show; end

    def new
      @user = User.new
      @user.user_info = UserInfo.new
    end

    def edit; end

    def create
      @user = User.new(user_params)
      @user.password = DEFAULT_PASSWORD

      respond_to do |format|
        if @user.save
          format.html do
            redirect_to @user.type == 'User' ? admins_user_url(@user) : admins_counselor_url(@user),
                        notice: 'User was successfully created.'
          end
        else
          flash[:alert] = @user.errors.full_messages.join(', ')
          format.html { redirect_to new_admins_user_path }
        end
      end
    end

    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html do
            redirect_to @user.type == 'User' ? admins_user_url(@user) : admins_counselor_url(@user),
                        notice: 'User was successfully updated.'
          end
        else
          flash[:alert] = @user.errors.full_messages
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @user.destroy

      respond_to do |format|
        format.html { redirect_to admins_users_url(page: params[:page]), notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def toggle_anonymous
      @user = User.find(params[:id])
      @user.update(anonymous: params[:anonymous])
      render json: { message: "The 'Anonymous' status has been successfully updated." }
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :anonymous, :password, :phone_number, :status, :type, :user_name,
                                   user_info_attributes: %i[address date_of_birth gender profile_name])
    end
  end
end
