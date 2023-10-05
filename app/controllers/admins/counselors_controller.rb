# frozen_string_literal: true

module Admins
  # Class CounselorsController for Admins
  class CounselorsController < AdminsLayoutController
    before_action :set_counselor, only: %i[show edit update destroy]

    DEFAULT_PASSWORD = '123456'

    def new
      @counselor = Counselor.new
      @counselor.counselor_info = counselorInfo.new
    end

    def create
      @counselor = Counselor.new(counselor_params)
      @counselor.password = DEFAULT_PASSWORD

      respond_to do |format|
        if @counselor.save
          format.html { redirect_to admins_counselor_url(@counselor), notice: 'counselor was successfully created.' }
        else
          flash[:alert] = @counselor.errors.full_messages
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @counselor.update(counselor_params)
          format.html { redirect_to admins_user_url(@counselor), notice: 'counselor was successfully updated.' }
        else
          flash[:alert] = @counselor.errors.full_messages
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_counselor
      @counselor = Counselor.find(params[:id])
    end

    def counselor_params
      params.require(:counselor).permit(:email, :anonymous, :password, :phone_number, :status, :type, :counselor_name,
                                        counselor_info_attributes: %i[address date_of_birth gender profile_name])
    end
  end
end
