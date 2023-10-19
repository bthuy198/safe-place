# frozen_string_literal: true

# rubocop:disable Rails/LexicallyScopedActionFilter

module Users
  module Confessions
    # module Confessions Controller contain callbacks
    module ConfessionsControllerCallbacksPart1
      extend ActiveSupport::Concern
      include Users::Confessions::ConfessionsControllerCallbacksPart2

      included do
        before_action :set_confessions, only: %i[index destroy]
        # rubocop:enable Rails/LexicallyScopedActionFilter
        include Kaminari::PageScopeMethods

        private

        def set_confessions
          if params[:q]
            confessions_search_and_paging
          else
            @confessions = Confession.includes(:rich_text_content,
                                               :user).order(created_at: :desc).page(params[:page]).per(3)
          end
          set_paging_variable
        end

        def confessions_search_and_paging
          @confessions = Kaminari.paginate_array(confessions_search).page(params[:page]).per(3)
        end

        def confessions_search
          @q = params[:q]
          ransack_results = Confession.ransack(tags_cont: @q).result
          user_results = Confession.where(anonymous: false).joins(:user)
                                   .ransack(user_user_name_cont: @q).result
          action_text_results = Confession.joins(:rich_text_content)
                                          .where('action_text_rich_texts.body LIKE ?', "%#{@q}%")
          (ransack_results + user_results + action_text_results).uniq.sort_by(&:created_at).reverse
        end
      end
    end
  end
end
