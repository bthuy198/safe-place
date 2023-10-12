# frozen_string_literal: true

# rubocop:disable Rails/LexicallyScopedActionFilter

module Users
  module Confessions
    # module Confessions Controller contain callbacks
    module ConfessionsControllerCallbacksPart2
      extend ActiveSupport::Concern

      included do
        before_action :authenticate_flash, only: %i[update destroy]
        before_action :authenticate_user!, only: %i[new create update destroy]
        # rubocop:enable Rails/LexicallyScopedActionFilter

        private

        def confession_params
          params[:confession][:tag] = params[:confession][:tag].split(' ')
          params.require(:confession).permit({ tag: [] }, :content, :anonymous, :user_id)
        end

        def authenticate_flash
          return if user_signed_in?

          render turbo_stream: turbo_stream
            .replace('flash',
                     partial: 'shared/flash',
                     locals: { flash:
                       { 'alert' => 'Please sign in to continue' } })
        end
      end
    end
  end
end
