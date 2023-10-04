# frozen_string_literal: true

module Admins
  # Class UsersController for Admins
  class UsersController < AdminsLayoutController
    before_action :set_user, only: %i[show edit update destroy]

    DEFAULT_PASSWORD = '123456'

    def index
      @users = User.includes(:user_info).order(id: :desc).page(params[:page])
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
          format.html { redirect_to admins_user_url(@user), notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to admins_user_url(@user), notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @user.destroy

      respond_to do |format|
        format.html { redirect_to admins_users_url, notice: 'User was successfully destroyed.' }
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
