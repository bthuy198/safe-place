# frozen_string_literal: true

module Users
  module Confessions
    # module Confessions Controller contain callbacks
    module ConfessionsControllerCallbacksPart2
      extend ActiveSupport::Concern

      included do
        private

        # for set_confessions method
        def tag_search
          Confession
            .eager_load(:rich_text_content, :user, :likes)
            .ransack(tags_cont: @q).result
        end

        # for set_confessions method
        def user_search
          Confession
            .eager_load(:rich_text_content, :user, :likes)
            .where(anonymous: false)
            .ransack(user_user_name_cont: @q).result
        end

        # for set_confessions method
        def content_search
          Confession
            .eager_load(:rich_text_content, :user, :likes)
            .where('action_text_rich_texts.body LIKE ?', "%#{@q}%")
        end

        # for set_confessions method
        def set_paging_variable
          @current_page = @confessions.current_page
          @total_pages = @confessions.total_pages
          @has_next_page = @current_page < @total_pages
        end
      end
    end
  end
end
