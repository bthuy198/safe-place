# frozen_string_literal: true

module Admins
  # Class CounselorsController for Admins
  class CounselorsController < AdminsLayoutController
    before_action :set_counselor, only: %i[show edit update destroy]

    DEFAULT_PASSWORD = '123456'

    def index
      @q = Counselor.includes(:user_info).ransack(params[:q])
      @counselors = @q.result(distinct: true).order(id: :desc).page params[:page]
    end

    def new
      @counselor = Counselor.new
      @counselor.user_info = UserInfo.new
    end

    def create
      @counselor = Counselor.new(counselor_params)
      @counselor.password = DEFAULT_PASSWORD

      respond_to do |format|
        if @counselor.save
          format.html { redirect_to @counselor.type == 'User' ? admins_user_url(@counselor) : admins_counselor_url(@counselor), notice: 'counselor was successfully created.' }
        else
          flash[:alert] = @counselor.errors.full_messages
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @counselor.update(counselor_params)

          format.html { redirect_to @counselor.type == 'User' ? admins_user_url(@counselor) : admins_counselor_url(@counselor), notice: 'counselor was successfully updated.' }
        else
          flash[:alert] = @counselor.errors.full_messages
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @counselor.destroy

      respond_to do |format|
        format.html do
          redirect_to admins_counselors_url(page: params[:page]), notice: 'Counselor was successfully destroyed.'
        end
        format.json { head :no_content }
      end
    end

    def toggle_anonymous
      @counselor = Counselor.find(params[:id])
      @counselor.update(anonymous: params[:anonymous])
      render json: { message: "The 'Anonymous' status has been successfully updated." }
    end

    def show; end

    def edit; end

    private

    def set_counselor
      @counselor = Counselor.find(params[:id])
    end

    def counselor_params
      params.require(:counselor).permit(:email, :anonymous, :password, :phone_number, :status, :type, :counselor_name,
                                        user_info_attributes: %i[address date_of_birth gender profile_name])
    end
  end
end
