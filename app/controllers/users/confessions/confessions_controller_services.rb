# frozen_string_literal: true

module Users
  module Confessions
    # module Confessions Controller contain services
    module ConfessionsControllerServices
      extend ActiveSupport::Concern

      included do
        def like
          respond_to do |format|
            if user_signed_in?
              LikeService.new(current_user, @confession).like
              format.turbo_stream do
                flash.now[:notice] = 'Confession liked/unliked successfully.'
              end
            else
              format.turbo_stream { flash.now[:alert] = 'Please login' }
            end
          end
        end
      end
    end
  end
end
