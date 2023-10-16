# frozen_string_literal: true

# rubocop:disable Rails/LexicallyScopedActionFilter

module Users
  module Confessions
    # module Confessions Controller contain callbacks
    module ConfessionsControllerCallbacksPart1
      extend ActiveSupport::Concern

      included do
        before_action :set_confessions, only: %i[index destroy]
        before_action :set_confession, only: %i[like show update destroy]
        # rubocop:enable Rails/LexicallyScopedActionFilter
        include Kaminari::PageScopeMethods

        private

        def set_confessions
          if params[:q]
            @q = params[:q]
            ransack_results = Confession.includes(:rich_text_content).ransack(tags_cont: @q).result
            action_text_results = Confession.joins(:rich_text_content).where('action_text_rich_texts.body LIKE ?', "%#{@q}%")
            combined_results = (ransack_results + action_text_results).uniq.sort_by(&:created_at).reverse
            @confessions = Kaminari.paginate_array(combined_results).page(params[:page]).per(3)
          else
            @confessions = Confession.includes(:rich_text_content).order(created_at: :desc).page(params[:page]).per(3)
          end
          @current_page = @confessions.current_page
          @total_pages = @confessions.total_pages
          @has_next_page = @current_page < @total_pages
        end

        def set_confession
          @confession = Confession.find_by(id: params[:id])
          return unless @confession.nil?

          respond_to do |format|
            format.html { redirect_to root_path, alert: 'Confession not found.' }
            format.json { head :no_content }
          end
        end
      end
    end
  end
end
