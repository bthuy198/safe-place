# frozen_string_literal: true

module Users
  module Confessions
    # module Confessions Controller contain destroy action
    module ConfessionsControllerDestroyAction
      extend ActiveSupport::Concern

      included do
        def destroy
          @confession.destroy

          respond_to do |format|
            format.turbo_stream do
              flash.now[:notice] = 'Confession was successfully destroyed.'
            end
            format.json { head :no_content }
          end
          Turbo::StreamsChannel.broadcast_remove_to('confessions_index_channel', target: helpers.dom_id(@confession))
        end
      end
    end
  end
end
