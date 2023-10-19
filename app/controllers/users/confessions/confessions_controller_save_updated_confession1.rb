# frozen_string_literal: true

module Users
  module Confessions
    # module Confessions Controller contain private method for update action
    module ConfessionsControllerSaveUpdatedConfession1
      extend ActiveSupport::Concern
      include Users::Confessions::ConfessionsControllerSaveUpdatedConfession2

      included do
        private

        def broadcast_updated_confession
          broadcast_updated_confession_card_body
          broadcast_updated_confession_card_tag
          broadcast_updated_confession_show
        end

        def broadcast_updated_confession_card_body
          Turbo::StreamsChannel
            .broadcast_update_later_to('confessions_index_channel',
                                       target: "#{helpers.dom_id(@confession)}_card_body",
                                       partial: 'users/confessions/confession_card_body',
                                       locals: { confession: @confession })
        end

        def broadcast_updated_confession_card_tag
          Turbo::StreamsChannel
            .broadcast_update_later_to('confessions_index_channel',
                                       target: "#{helpers.dom_id(@confession)}_card_tag",
                                       partial: 'users/confessions/confession_card_tag',
                                       locals: { confession: @confession })
        end
      end
    end
  end
end
