# frozen_string_literal: true

module Users
  module Confessions
    # module Confessions Controller contain destroy action
    module ConfessionsControllerDestroyAction
      extend ActiveSupport::Concern

      included do
        def destroy
          respond_to do |format|
            if current_user.id == @confession.user_id
              @confession.destroy
              format.turbo_stream do
                flash.now[:notice] = 'Confession was successfully destroyed.'
              end
              format.json { head :no_content }
              Turbo::StreamsChannel.broadcast_remove_to('confessions_index_channel',
                                                        target: helpers.dom_id(@confession))
            else
              format.turbo_stream do
                flash.now[:alert] = "Cannot delete other people's confessions"
              end
            end
          end
          broadcast_destroy_confession
        end

        def broadcast_destroy_confession
          Turbo::StreamsChannel
            .broadcast_remove_to('confessions_index_channel',
                                 target: helpers.dom_id(@confession))
          Turbo::StreamsChannel
            .broadcast_remove_to('not_signed_in_confessions_index_channel',
                                 target: helpers.dom_id(@confession))
        end
      end
    end
  end
end
