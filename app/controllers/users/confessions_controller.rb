# frozen_string_literal: true

module Users
  class ConfessionsController < UsersLayoutController
    before_action :set_confessions, only: %i[index destroy]
    before_action :set_confession, only: %i[show update destroy]
    before_action :authenticate_flash, only: %i[update destroy]
    before_action :authenticate_user!, only: %i[new create update destroy]

    def index
      respond_to do |format|
        format.html
        format.turbo_stream
      end
    end

    def show; end

    def new
      @confession = Confession.new
    end

    def create
      @confession = Confession.new(confession_params)
      @confession.user_id = current_user.id
      if @confession.save
        respond_to do |format|
          format.turbo_stream { flash.now[:notice] = 'Confession was successfully created.' }
          format.json { render :show, status: :created, location: @confession }
        end
        Turbo::StreamsChannel.broadcast_prepend_later_to("confessions_index_channel", target: "confessions", partial: "users/confessions/confession_index", locals: { confession: @confession })
      else
        respond_to do |format|
          format.turbo_stream do
            flash.now[:alert] = "<ul><li>#{@confession.errors.full_messages.join("</li><li>")}</li><ul>".html_safe
            render status: :unprocessable_entity
          end
          format.json { render json: @confession.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      if @confession.update(confession_params)
        respond_to do |format|
          format.turbo_stream { flash.now[:notice] = 'Confession was successfully updated.' }
          format.json { render :show, status: :ok, location: @confession }
        end
        Turbo::StreamsChannel.broadcast_replace_later_to("confessions_index_channel", target: helpers.dom_id(@confession), partial: "users/confessions/confession_index", locals: { confession: @confession })
        Turbo::StreamsChannel.broadcast_update_later_to("confessions_show_channel", target: "#{helpers.dom_id(@confession)}_show", partial: "users/confessions/confession", locals: { confession: @confession })
      else
        respond_to do |format|
          format.turbo_stream do
            flash.now[:alert] = "<ul><li>#{@confession.errors.full_messages.join("</li><li>")}</li><ul>".html_safe
            render status: :unprocessable_entity
          end
          format.json { render json: @confession.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @confession.destroy

      respond_to do |format|
        format.turbo_stream do
          flash.now[:notice] = 'Confession was successfully destroyed.'
        end
        format.json { head :no_content }
      end
      Turbo::StreamsChannel.broadcast_remove_to("confessions_index_channel", target: helpers.dom_id(@confession))
    end

    private

    def set_confessions
      @confessions = Confession.order(created_at: :desc).page(params[:page]).per(3)
      @current_page = @confessions.current_page
      @total_pages = @confessions.total_pages
      @has_next_page = @current_page < @total_pages
    end

    def set_confession
      @confession = Confession.find_by(id: params[:id])
      if @confession.nil?
        respond_to do |format|
          format.html { redirect_to root_path, alert: 'Confession not found.' }
          format.json { head :no_content }
        end
      end
    end

    def confession_params
      params[:confession][:tag] = params[:confession][:tag].split(" ")
      params.require(:confession).permit({tag: []}, :content, :anonymous, :user_id)
    end

    def authenticate_flash
      unless user_signed_in?
        render turbo_stream: turbo_stream.replace( "flash", partial: "shared/flash", locals: { flash: {"alert" => "Please sign in to continue"} })
      end
    end
  end
end
