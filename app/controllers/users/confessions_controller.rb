# frozen_string_literal: true

module Users
  class ConfessionsController < UsersLayoutController
    before_action :set_confession, only: %i[show edit update destroy]
    before_action :authenticate_user!, only: %i[new create edit update destroy]

    def index
      @confessions = Confession.all
    end

    def show; end

    def new
      @confession = Confession.new
    end

    def edit; end

    def create
      @confession = Confession.new(confession_params)
      @confession.user_id = current_user.id
      @confession.anonymous = current_user.anonymous
      respond_to do |format|
        if @confession.save
          format.html { redirect_to users_confessions_path, notice: 'Confession was successfully created.' }
          format.json { render :show, status: :created, location: @confession }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @confession.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @confession.update(confession_params)
          format.html { redirect_to users_confessions_path, notice: 'Confession was successfully updated.' }
          format.json { render :show, status: :ok, location: @confession }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @confession.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @confession.destroy

      respond_to do |format|
        format.html { redirect_to users_confessions_path, notice: 'Confession was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_confession
      @confession = Confession.find_by(id: params[:id])
    end

    def confession_params
      params.require(:confession).permit(:tag, :content, :anonymous, :user_id)
    end
  end
end
